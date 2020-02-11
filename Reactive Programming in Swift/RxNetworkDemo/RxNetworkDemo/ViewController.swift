//
//  ViewController.swift
//  RxNetworkDemo
//
//  Created by Song Zixin on 2020/2/6.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import RxDataSources

class ViewController: UIViewController {
    @IBOutlet weak var repositoryName: UITextField!
    @IBOutlet weak var searchResult: UITableView!

    
    var bag = DisposeBag()

    
    typealias SectionTableModel = SectionModel<String, RepositoryModel>

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.searchResult.delegate = self
        
        self.searchResult.rxDidSelectRowAtIndexPath.subscribe(onNext: {
            print("From delegate proxy")
            $0.deselectRow(at: $1, animated: true)
            }).disposed(by: bag)
        
//        self.searchResult.rx.itemSelected.subscribe(onNext: {
//            self.searchResult.deselectRow(at: $0, animated: true)
//            print("xixi")
//        })
        
        self.repositoryName.rx.text
            .orEmpty
            .filter {
                $0.count > 2
        }
        .throttle(.seconds(1), scheduler: MainScheduler.instance)
        .flatMap {
            self.searchForGithub(repositoryName: $0)
        }
//        .subscribe(onNext: {
//            let repoCount = $0.count
//            if repoCount != 0 {
//                print("item count: \(repoCount)")
//
//                for item in $0 {
//                    print("---------------------------------")
//
//                    let name = item.name
//                    let description = item.detail
//                    let avatarUrl = item.avatar
//                    let htmlUrl = item.htmlUrl
//                    print("full name: \(name)")
//                    print("description: \(description)")
//                    print("htmlUrl: \(htmlUrl)")
//                    print("avatar_url: \(avatarUrl)")
//                }
//            }
//        }).disposed(by: bag)
            .subscribe(
                onNext: { repositoryModelArray in
//                    typealias O = Observable<[RepositoryModel]>
//                    typealias CC = (Int, RepositoryModel, RepositoryInfoTableViewCell) -> Void
//                    let binder: (O) -> (CC) -> Disposable = self.searchResult.rx.items(cellIdentifier: "RepositoryInfoCell", cellType: RepositoryInfoTableViewCell.self)
                    
                    self.searchResult.dataSource = nil

                    let dataSource = RxTableViewSectionedReloadDataSource<SectionTableModel>(configureCell: { dataSource, tableView, indexPath, element  in
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryInfoCell", for: indexPath) as! RepositoryInfoTableViewCell
                        cell.name.text = element.name
                        cell.detail.text = element.detail
                        return cell
                    })

//                    dataSource.configureCell = { dataSource, tableView, indexPath, element  in
//
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryInfoCell", for: indexPath) as! RepositoryInfoTableViewCell
//                        cell.name.text = element.name
//                        cell.detail.text = element.detail
//                        return cell
//                    }
                    

//                    let curriedArgument = { (rowIndex: Int, element: RepositoryModel, cell: RepositoryInfoTableViewCell) in
//                        cell.name?.text = element.name
//                        cell.detail?.text = element.detail
//                    }
                                        
//                    Observable.just(repositoryModelArray)
//                        .bind(to: self.searchResult.rx.items(cellIdentifier: "RepositoryInfoCell", cellType: RepositoryInfoTableViewCell.self), curriedArgument: curriedArgument)
                    
                    Observable.just(self.createGithubSectionModel(repoInfo: repositoryModelArray))
                        .bind(to: self.searchResult.rx.items(dataSource: dataSource))
                        .disposed(by:self.bag)

            },
                onError: { error in
                    self.displayErrorAlert(error: error)
                    print("error")
            }
        ).disposed(by: bag)
        
    }
}

extension ViewController {
    private func searchForGithub(repositoryName: String) -> Observable<[RepositoryModel]> {

        return Observable.create {
            (observer: AnyObserver<[RepositoryModel]>) -> Disposable in
            let url = "https://api.github.com/search/repositories"
            let parameter = [
                "q": repositoryName + "stars:>=2000"
            ]
            let request = AF.request(url, method: .get, parameters: parameter, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
                switch response.result {
                case .success(let json):
                    let info = self.parseGithubResponse(response: json)
                    observer.onNext(info)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }

            }
            return Disposables.create {
                request.cancel()
            }
        }
}
    
    private func parseGithubResponse(response: Any) -> [RepositoryModel] {
        
        let json = JSON(response)
        let totalCount = json["total_count"].int!
        
        var ret: [RepositoryModel] = []
        
        if totalCount != 0 {
            let items = json["items"]
            for (_, subJson): (String, JSON) in items {
                let fullName = subJson["full_name"].string!
                let description = subJson["description"].string!
                let htmlUrl = subJson["html_url"].string!
                let avatarUrl = subJson["owner"]["avatar_url"].string!
                
                ret.append(RepositoryModel(name: fullName, detail: description, htmlUrl: htmlUrl, avatar: avatarUrl))
            }
        }
        return ret
        
    }
    
    private func createGithubSectionModel(repoInfo: [RepositoryModel]) -> [SectionTableModel] {
        var ret: [SectionTableModel] = []
        var items: [RepositoryModel] = []
        
        if repoInfo.count <= 10 {
            let sectionLabel = "Top 1 - 10"
            items = repoInfo
            ret.append(SectionTableModel(model: sectionLabel, items: items))
        } else {
            for i in 1...repoInfo.count {
                items.append(repoInfo[i - 1])
                
                if i / 10 != 0 && i % 10 == 0 {
                    let sectionLabel = "Top \(i - 9) - \(i)"
                    ret.append(SectionTableModel(model: sectionLabel, items: items))
                    items = []
                }
            }
        }
        return ret
        
    }
    
    private func displayErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Network error", message: error.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//extension ViewController: UITableViewDelegate {
//    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        print("from original delegate")
//    }
//
//}



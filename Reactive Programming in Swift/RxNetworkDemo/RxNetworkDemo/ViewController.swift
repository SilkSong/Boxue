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

class ViewController: UIViewController {
    @IBOutlet weak var repositoryName: UITextField!
    @IBOutlet weak var searchResult: UITableView!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repositoryName.rx.text
            .orEmpty
            .filter {
                $0.count > 2
        }
        .throttle(.seconds(1), scheduler: MainScheduler.instance)
        .flatMap {
            self.searchForGithub(repositoryName: $0)
        }
        .subscribe(onNext: {
            let repoCount = $0["total_count"] as! Int;
            let repoItems = $0["items"] as! [RepositoryInfo];
                        
            if repoCount != 0 {
                print("item count: \(repoCount)")
                            
                for item in repoItems {
                    print("---------------------------------")
                                
                    let name = item["full_name"]
                    let description = item["description"]
                    let avatarUrl = item["avatar_url"]

                                
                    print("full name: \(name!)")
                    print("description: \(description!)")
                    print("avatar_url: \(avatarUrl!)")
                }
            }
        }).disposed(by: bag)
        
    }

}

extension ViewController {
    typealias RepositoryInfo = Dictionary<String, Any>
    
    private func searchForGithub(repositoryName: String) -> Observable<RepositoryInfo> {
        return Observable.create {
            (observer: AnyObserver<RepositoryInfo>) -> Disposable in
            let url = "https://api.github.com/search/repositories"
            let parameters = [
                "q": repositoryName + "stars:>=2000"
            ]
            
            let request = AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        //handle success
                        let info = self.parseGithubResponse(response: json)
                        observer.on(.next(info))
                        observer.on(.completed)
                    case .failure(let error):
                        observer.on(.error(error))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func parseGithubResponse(response: Any) -> RepositoryInfo {
        let json = JSON(response)
        let totalCount = json["total_count"].int!
        
        var ret: RepositoryInfo = [
            "total_count": totalCount,
            "items": []
        ]
        if totalCount != 0 {
            let items = json["items"]
            var info: [RepositoryInfo] = []
            
            for (_, subJson):(String, JSON) in items {
                let fullName = subJson["full_name"].string!
                let description = subJson["description"].string!
                let htmlUrl = subJson["html_url"].string!
                let avatarUrl = subJson["owner"]["avatar_url"].string!
                
                info.append([
                    "full_name": fullName,
                    "description": description,
                    "html_url": htmlUrl,
                    "avatar_url": avatarUrl
                ])
            }
            ret["items"] = info
        }
        return ret
    }
    
}


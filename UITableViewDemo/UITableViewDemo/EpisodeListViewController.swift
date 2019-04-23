//
//  ViewController.swift
//  UITableViewDemo
//
//  Created by Song Zixin on 2019/4/23.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
    
    var episodeListItems: [EpisodeListItem] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadEpisodeListItems()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docUrl = documentsDirectory()
        let file = fileUrl("EpisodeList.plist")
        
        print("Document url: \(docUrl)")
        print("Data file url: \(file)")
    }

}

//MARK: TableViewDelegate, DataSource
extension EpisodeListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeItem", for: indexPath)
        let label = cell.viewWithTag(1024) as! UILabel
        label.text = episodeListItems[indexPath.row].title
        cell.accessoryType = episodeListItems[indexPath.row].finished ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Access directory
extension EpisodeListViewController {
    
    // Access the documents directory
    func documentsDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }
    
    //Create a file url
    func fileUrl(_ fileName: String) -> URL {
        let documentUrl = documentsDirectory().appendingPathComponent(fileName)
    
        return documentUrl
    }
    
}

//MARK: Load and Save plist
extension EpisodeListViewController {
    
    //Initialize the array
    func getEpisodeListItemData() {
        for i in 0..<10 {
            let e = EpisodeListItem()
            e.title = "Episode \(i)"
            e.finished = Bool(truncating: NSNumber(value: i % 2)) ? true : false
            episodeListItems.append(e)
        }
    }
    
    func loadEpisodeListItems() {
        
        let episodeUrl = fileUrl("EpisodeList.plist")
        let fileExist = FileManager.default.fileExists(atPath: episodeUrl.path)
        
        if fileExist {
            if let data = try? Data(contentsOf: episodeUrl) {
                let decoder = PropertyListDecoder()
                episodeListItems = try! decoder.decode([EpisodeListItem].self, from: data)
            }
            
        } else {
            getEpisodeListItemData()
            saveEpisodeListItems()
        }
    }
    
    //
    func saveEpisodeListItems() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        let path = fileUrl("EpisodeList.plist")

        do {
            let data = try encoder.encode(episodeListItems)
            try data.write(to: path)
        } catch {
            print(error)
        }
    }
}

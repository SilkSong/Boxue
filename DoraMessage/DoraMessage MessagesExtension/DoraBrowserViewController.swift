//
//  DoraBrowserViewController.swift
//  DoraMessage MessagesExtension
//
//  Created by Song Zixin on 2019/5/1.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit
import Messages

class DoraBrowserViewController: MSStickerBrowserViewController {

    let stickerNames = ["act_catch", "act_dizzy", "eat_dream", "eat_full", "eat_drink","act_find", "act_fly", "act_magic", "act_sing", "act_sit"]
    var stickers: [MSSticker]!
    
    @IBAction func changeIconCollection(_ sender: UISegmentedControl) {
        var collType = ""
        switch sender.selectedSegmentIndex {
        case 1:
            collType = "eat"
        case 2:
            collType = "act"
        default:
            collType = ""
        }
        
        for vc in self.children {
            if let doraVC = vc as? DoraBrowserViewController {
                doraVC.updateSticks(of: collType)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stickerBrowserView.backgroundColor = UIColor(displayP3Red: 0, green: 188, blue: 212, alpha: 1)
        self.loadStickers(of: "")
    }
    
}

extension DoraBrowserViewController {
    public func loadStickers(of act: String) {
        if act == "" {
            self.stickers = stickerNames.map { try! MSSticker(item: $0) }
        } else {
            self.stickers = stickerNames.filter { $0.contains(act) }.map { try! MSSticker(item: $0 )}
            let filer =  stickerNames.filter { $0.contains(act) }
            print(filer)
        }
    }
    
    public func updateSticks(of act: String) {
        self.loadStickers(of: act)
        //在更新MSStickers数组后，更新view controller中显示stickers的view；
        self.stickerBrowserView.reloadData()
    }
}

extension DoraBrowserViewController {
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return stickers.count
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return stickers[index]
    }
}

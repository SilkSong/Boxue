//
//  Downloader.swift
//  GCDDemo
//
//  Created by Mars on 1/30/16.
//  Copyright © 2016 Boxue. All rights reserved.
//

import UIKit
class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
//        let data = NSData(contentsOfURL: NSURL(string: url)! as URL)
//        return UIImage(data: data!)
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}

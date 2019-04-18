//
//  ViewController.swift
//  GCDDemo
//
//  Created by Mars on 1/30/16.
//  Copyright © 2016 Boxue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let queue = OperationQueue()

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    let imageUrls = [
        "https://images.unsplash.com/photo-1553531580-54bcdf7bc851?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
        "https://images.unsplash.com/photo-1555078173-2a2d3aec7316?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
        "https://images.unsplash.com/photo-1555089673-0b4b69c076d9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
        "https://images.unsplash.com/photo-1555089718-0ca5f5e42da7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clearDownload(sender: UIButton) {
        self.image1.image = nil
        self.image2.image = nil
        self.image3.image = nil
        self.image4.image = nil
    
        URLCache.shared.removeAllCachedResponses()
    }

    @IBAction func cancelDownload(_ sender: Any) {
        queue.cancelAllOperations()
    }
    
    @IBAction func downloadInMainThread(sender: UIButton) {
        //串行队列 异步开启任务
        let serialQueue = DispatchQueue(label: "com.boxue.images")
        serialQueue.async {
            let image1 = Downloader.downloadImageWithURL(self.imageUrls[0])
            DispatchQueue.main.async {
                self.image1.image = image1
                    self.image1.clipsToBounds = true
            }

            let image2 = Downloader.downloadImageWithURL(self.imageUrls[1])
            DispatchQueue.main.async {
                self.image2.image = image2
                self.image2.clipsToBounds = true
            }

            let image3 = Downloader.downloadImageWithURL(self.imageUrls[2])
            DispatchQueue.main.async {
                self.image3.image = image3
                self.image3.clipsToBounds = true
            }

            let image4 = Downloader.downloadImageWithURL(self.imageUrls[3])
            DispatchQueue.main.async {
                self.image4.image = image4
                self.image4.clipsToBounds = true
            }
        }
        
        //并行队列 异步开启任务
        
//        let concurrentQueue = DispatchQueue(label: "com.boxue.images", attributes: .concurrent)
//        concurrentQueue.async {
//
//            let image1 = Downloader.downloadImageWithURL(self.imageUrls[0])
//            DispatchQueue.main.async {
//                self.image1.image = image1
//                self.image1.clipsToBounds = true
//            }
//
//            let image2 = Downloader.downloadImageWithURL(self.imageUrls[1])
//            DispatchQueue.main.async {
//                self.image2.image = image2
//                self.image2.clipsToBounds = true
//            }
//
//            let image3 = Downloader.downloadImageWithURL(self.imageUrls[2])
//            DispatchQueue.main.async {
//                self.image3.image = image3
//                self.image3.clipsToBounds = true
//            }
//
//            let image4 = Downloader.downloadImageWithURL(self.imageUrls[3])
//            DispatchQueue.main.async {
//                self.image4.image = image4
//                self.image4.clipsToBounds = true
//            }
//        }
        
        //使用 NSOperationQueue
        
//        let op2 = BlockOperation(block: {
//            let img2 = Downloader.downloadImageWithURL(self.imageUrls[1])
//
//            OperationQueue.main.addOperation {
//                self.image2.image = img2
//                self.image2.clipsToBounds = true
//            }
//        })
//
//        op2.completionBlock = { print("image2 is cancelled: \(op2.isCancelled)") }
//
//        let op3 = BlockOperation(block: {
//            let img3 = Downloader.downloadImageWithURL(self.imageUrls[2])
//
//            OperationQueue.main.addOperation {
//                self.image3.image = img3
//                self.image3.clipsToBounds = true
//            }
//        })
//        op3.completionBlock = { print("image3 is cancelled: \(op3.isCancelled)") }
//
//        let op4 = BlockOperation(block: {
//            let img4 = Downloader.downloadImageWithURL(self.imageUrls[3])
//
//            OperationQueue.main.addOperation {
//                self.image4.image = img4
//                self.image4.clipsToBounds = true
//            }
//        })
//        op4.completionBlock = { print("image4 is cancelled: \(op4.isCancelled)") }
//
//        op3.addDependency(op4)
//        op2.addDependency(op3)
//
//        queue.addOperation(op2)
//        queue.addOperation(op3)
//        queue.addOperation(op4)
//
//
//
//        queue.addOperation {
//            let image1 = Downloader.downloadImageWithURL(self.imageUrls[0])
//            OperationQueue.main.addOperation {
//                self.image1.image = image1
//                self.image1.clipsToBounds = true
//            }
//        }
        
    }
}


//
//  ViewController.swift
//  AlamoFireDemo
//
//  Created by Mars on 2/11/16.
//  Copyright © 2016 Boxue. All rights reserved.
//

import UIKit
import Alamofire

enum DownloadStatus {
    case NotStarted
    case Downloading
    case Suspended
    case Cancelled
}

class ViewController: UIViewController {
    var currStatus = DownloadStatus.NotStarted
    
    @IBOutlet weak var downloadUrl: UITextField!
    @IBOutlet weak var downloadProgress: UIProgressView!
    @IBOutlet weak var beginBtn: UIButton!
    @IBOutlet weak var suspendOrResumeBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!


    
    @IBAction func valueChanged(_ sender: UITextField) {
        print("text field: \(String(describing: sender.text))")
        
        if sender.text != "" {
            self.beginBtn.isEnabled = true
        }
        else {
            self.beginBtn.isEnabled = false
        }
    }
    
    
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        if FileManager.default.fileExists(atPath: self.episodesDirUrl.path) {
//            try! FileManager.default
//                .createDirectory(at: self.episodesDirUrl,
//                                withIntermediateDirectories: true,
//                                attributes: nil)
//        } else {
//            print("File path not available")
//        }
//    }
//
}

//extension ViewController {
//    var documentsDirUrl: URL {
//        let fm = FileManager.default
//        let url = fm.urls(for: .documentDirectory,
//                          in: .userDomainMask)[0]
//
//        return url
//    }
//
//    var episodesDirUrl: URL {
//        let url = self.documentsDirUrl
//            .appendingPathComponent("episodes", isDirectory: true)
//
//        return url
//    }
//}

extension ViewController {
    
    
    

    
    // Button actions
    @IBAction func beginDownload(sender: AnyObject) {
        print("Begin downloading...")
        
        // TODO: Add begin downloading code here
        
//        let destination: DownloadRequest.DownloadFileDestination = { temporaryURL, response in
//            print(temporaryURL)
//
//            let pathComponent = response.suggestedFilename
//            let episodeUrl =
//                self.episodesDirUrl.appendingPathComponent(pathComponent!)
//
//            if FileManager.default.fileExists(atPath: self.episodesDirUrl.path) {
//                print("Clear the previous existing file.")
//                print(self.episodesDirUrl.path)
//                let fm = FileManager.default
//                try! fm.removeItem(at: episodeUrl)
//            } else {
//                print("file path not available")
//            }
//
//            return (episodeUrl, [.removePreviousFile, .createIntermediateDirectories])
//        }
//
//
//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let fileURL = documentsURL.appendingPathComponent("pig.png")
//
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
//
//        if let resUrl = self.downloadUrl.text {
//            Alamofire.download(resUrl, to: destination)
//        }
        
        self.suspendOrResumeBtn.isEnabled = true;
        self.cancelBtn.isEnabled = true;
        self.currStatus = .Downloading
    }
    
    @IBAction func suspendOrResumeDownload(sender: AnyObject) {
        var btnTitle: String?
        
        switch self.currStatus {
        case .Downloading:
            print("Suspend downloading...")
            
            // TODO: Add suspending code here
            
            
            self.currStatus = .Suspended
            btnTitle = "Resume"
            
        case .Suspended:
            print("Resume downloading...")
            
            // TODO: Add resuming code here
            self.currStatus = .Downloading
            btnTitle = "Suspend"
            
        case .NotStarted, .Cancelled:
            break
        }
        
        self.suspendOrResumeBtn.setTitle(btnTitle, for: .normal)
        
    }
    
    @IBAction func cancelDownload(sender: AnyObject) {
        print("Cancel downloading...")
        
        switch self.currStatus {
        case .Downloading, .Suspended:
            // TODO: Add cancel code here
            
            self.currStatus = .Cancelled
            self.cancelBtn.isEnabled = false
            self.suspendOrResumeBtn.isEnabled = false
            self.suspendOrResumeBtn.setTitle("Suspend", for: .normal)
        default:
            break
        }
    }
}

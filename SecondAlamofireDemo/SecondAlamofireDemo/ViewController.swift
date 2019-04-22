//
//  ViewController.swift
//  SecondAlamofireDemo
//
//  Created by Song Zixin on 2019/4/22.
//  Copyright © 2019 SilkSong. All rights reserved.
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
    
    var currentStatus = DownloadStatus.NotStarted
    
    @IBOutlet weak var downloadUrl: UITextField!
    @IBOutlet weak var beginBtn: UIButton!
    @IBOutlet weak var suspendOrResumeBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var downloadProgress: UIProgressView!
    @IBOutlet weak var dowloadProgressLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if FileManager.default.fileExists(atPath: episodesDirectoryUrl.path) {
            try! FileManager.default.createDirectory(at: episodesDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
            
            print(episodesDirectoryUrl.path)
        } else {
            print("Path not available")
        }
    }
    
}




extension ViewController {
    var documentsDirectoryUrl: URL {
        let fm = FileManager.default
        let url = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        return url
    }
    
    var episodesDirectoryUrl: URL {
        let url = documentsDirectoryUrl.appendingPathComponent("episodes", isDirectory: true)
        
        return url
    }
}


extension ViewController {
    @IBAction func valueChanged(_ sender: UITextField) {
        print("text field: \(String(describing: sender.text))")
        
        if sender.text != "" {
            beginBtn.isEnabled = true
            beginBtn.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        }
        else {
            beginBtn.isEnabled = false
            beginBtn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .disabled)
        }
    }
    
    @IBAction func beginDownload(_ sender: UIButton) {
        
        print("Begin downloading")
        
        //TODO: Add begin downloading code here
        
        let destination: DownloadRequest.DownloadFileDestination = { temporaryURL, response in
            print("temporaryURL is \(temporaryURL)")

            let pathComponent = response.suggestedFilename
            print("suggestedFilename is \(String(describing: pathComponent))")
            let episodeUrl =
                self.episodesDirectoryUrl.appendingPathComponent(pathComponent!)
            print("episodeUrl.path is \(episodeUrl.path)")

            let fm = FileManager.default
            if fm.fileExists(atPath: episodeUrl.path) {
                print("Clear the previous existing file.")
                try! fm.removeItem(at: episodeUrl)
            }

            return (episodeUrl, [.removePreviousFile, .createIntermediateDirectories])
        }

        if let resUrl = self.downloadUrl.text {
            Alamofire.download(resUrl, to: destination)
                .downloadProgress{ progress  in
                    // This closure is NOT called on the main queue for performance
                    // reasons. To update your ui, dispatch to the main queue.
                    DispatchQueue.main.async {
                        self.downloadProgress.progress = Float(progress.fractionCompleted)
                        self.dowloadProgressLabel.text = "\(Float(progress.fractionCompleted))"
                    }
            }
            .response { request in
                    if let error = request.error {
                        print("Download error: \(error.localizedDescription)")
                    }
            }
        }
        
        cancelBtn.isEnabled = true
        suspendOrResumeBtn.isEnabled = true
        
        cancelBtn.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        suspendOrResumeBtn.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        self.currentStatus = .Downloading
    }
    
    
    @IBAction func suspendOrResumeDownload(_ sender: UIButton) {
        var btnTitle: String?
        
        switch currentStatus {
        case .Downloading:
            print("Suspend downloading...")
            
        //TODO: Add suspending code here
            
            currentStatus = .Suspended
            btnTitle = "Resume"
            
        case .Suspended:
            print("Resume downloading...")
            
        //TODO: Add resuming code here
            currentStatus = .Downloading
            btnTitle = "Suspend"
            
        case .NotStarted, .Cancelled:
            break
        }
        
        suspendOrResumeBtn.setTitle(btnTitle, for: .normal)
    }
    
    
    @IBAction func cancelDownload(_ sender: UIButton) {
        print("Cancel downloading...")
        
        switch currentStatus {
        case .Downloading, .Suspended:
        //TODO: Add cancel code here
            currentStatus = .Cancelled
            cancelBtn.isEnabled = false
            suspendOrResumeBtn.isEnabled = false
            
            cancelBtn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .disabled)
            suspendOrResumeBtn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .disabled)
        
            suspendOrResumeBtn.setTitle("Suspend", for: .normal)
        default:
            break
        }
    }
    
    
}

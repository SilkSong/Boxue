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
    
    var episodeUrl: URL?
    var currentStatus = DownloadStatus.NotStarted
    var request: Alamofire.DownloadRequest?
    
    @IBOutlet weak var downloadUrl: UITextField!
    @IBOutlet weak var beginBtn: UIButton!
    @IBOutlet weak var suspendOrResumeBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
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
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            
            let pathComponent = response.suggestedFilename
            let episodeUrl =
                self.episodesDirectoryUrl.appendingPathComponent(pathComponent!)
            print("episodeUrl.path is \(episodeUrl.path)")
            

            self.episodeUrl = episodeUrl
            return (episodeUrl, [.removePreviousFile, .createIntermediateDirectories])
        }

        if let resUrl = self.downloadUrl.text {
            self.request = Alamofire.download(resUrl, to: destination)
            Alamofire.download(resUrl, to: destination)
                .downloadProgress{ progress  in
                    DispatchQueue.main.async {
                        self.downloadProgress.progress = Float(progress.fractionCompleted)
                        self.dowloadProgressLabel.text = "Progress: \(Float(progress.fractionCompleted))"
                    }
            }
            .responseData { response in
                    if let error = response.result.error {
                        print("Download error: \(error.localizedDescription)")

                        if let data = response.resumeData {
                            print("Resume data exists")
                            self.displayNetworkAlert(errorMessage: error.localizedDescription, data: data, destination: destination)
                        } else {
                            print("Resume data is nil")
                            self.displayNetworkAlert(errorMessage: error.localizedDescription)
                        }
                    }
                    else {
                        let alert = UIAlertController(title: "Success", message: "Download finished successfully!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            print("Finish downloading...")

                            self.restoreDownloadUserInterface()
                            
                        }))
                        self.present(alert,
                                     animated: true, completion: nil)

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
            
            self.request!.suspend()
            
        case .Suspended:
            print("Resume downloading...")
            
        //TODO: Add resuming code here
            currentStatus = .Downloading
            btnTitle = "Suspend"
            self.request!.resume()
            
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
            
            self.request!.cancel()
            
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
    
    @IBAction func uploadFile(_ sender: UIButton) {
        guard self.episodeUrl != nil else {
            print("Does not have any downloaded file")
            return
        }
        
        print("Uploading \(self.episodeUrl!)")
        
        
    }
    
    
}

extension ViewController {
    private func displayNetworkAlert(errorMessage: String,
                                     data: Data? = nil,
                                     destination: DownloadRequest.DownloadFileDestination? = nil) {
        let alert = UIAlertController(
            title: "Network error",
            message: errorMessage,
            preferredStyle: .alert)
        
        if let data = data {
            alert.addAction(UIAlertAction(title: "Resume",
                                          style: .default,
                                          handler: { _ in
                                            // Resume download here
                                            print("Resume downloading...")
                                            if let destination = destination {
                                                do {
                                                    Alamofire.download(resumingWith: data, to: destination)
                                                        .downloadProgress{ progress  in
                                                            DispatchQueue.main.async {
                                                                self.downloadProgress.progress = Float(progress.fractionCompleted)
                                                                self.dowloadProgressLabel.text = "\(Float(progress.fractionCompleted))"
                                                            }
                                                    }
                                                    
                                                }
                                            }
                                            
                                            
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel",
                                          style: .cancel,
                                          handler: { _ in
                                            // Reset the app
                                            print("Cancel downloading...")
                                            self.restoreDownloadUserInterface()

            }))
            
        }
        else {
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { _ in
                                            // Cancel download here
                                            print("Cancel downloading...")
                                            self.restoreDownloadUserInterface()
            }))
        }
        
        self.present(alert,
                     animated: true, completion: nil)
    }
    
    func restoreDownloadUserInterface() {
        self.downloadUrl.text = nil
        self.downloadProgress.progress = 0
        self.dowloadProgressLabel.text = "Progress: "
        self.beginBtn.isEnabled = false
        self.suspendOrResumeBtn.isEnabled = false
        self.cancelBtn.isEnabled = false
    }
}

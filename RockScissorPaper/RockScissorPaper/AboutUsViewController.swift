//
//  AboutUsViewController.swift
//  RockScissorPaper
//
//  Created by Mars on 1/1/16.
//  Copyright © 2016 Boxue. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var aboutUs: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let htmlFile = Bundle.main.path(forResource: "aboutus", ofType: "html")
        
        if (htmlFile != nil) {
            if let htmlData = NSData(contentsOfFile: htmlFile!) {
                let mainBundleUrl =
                    NSURL(fileURLWithPath: Bundle.main.bundlePath)
                
                self.aboutUs.load(htmlData as Data,
                                  mimeType: "text/html",
                                      textEncodingName: "UTF-8",
                                      baseURL: mainBundleUrl as URL)
            }
        }
        
        self.view.setNeedsDisplay()
    }


    @IBAction func close(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

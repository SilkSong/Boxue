//
//  AppDelegate.swift
//  iOS 101
//
//  Created by Song Zixin on 2019/4/21.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var redView: MyView?
    var yellowView: MyView?
    var greenView: MyView?
    
    private func makeMyView(frame: CGRect, bgColor: UIColor) -> MyView {
        let view = MyView(frame: frame)
        view.backgroundColor = bgColor
        
        return view
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window!.backgroundColor = UIColor.brown
        
        self.window!.rootViewController = UIViewController()
        
        
        self.redView = makeMyView(frame: CGRect(x: 60, y: 60, width: 160, height: 280), bgColor: .red)
        self.yellowView = makeMyView(frame: CGRect(x: 140, y: 135, width: 160, height: 280), bgColor: .yellow)
        self.greenView = makeMyView(frame: self.redView!.bounds.insetBy(dx: 10, dy: 10), bgColor: .green)
        
        self.redView?.addSubview(self.greenView!)

        
        let rootView = self.window!.rootViewController?.view
        
        rootView?.addSubview(self.redView!)
        //rootView?.addSubview(self.yellowView!)
        
        self.redView?.clipsToBounds = true
        
        let greenViewCenter = rootView?.convert(
            self.redView!.center,
            to: self.redView)
        
        print(greenViewCenter)

        self.window!.makeKeyAndVisible()
        return true
    }
}


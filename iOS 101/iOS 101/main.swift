//
//  main.swift
//  iOS 101
//
//  Created by Song Zixin on 2019/4/21.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit


UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(MyApp.self),
    NSStringFromClass(AppDelegate.self)
)


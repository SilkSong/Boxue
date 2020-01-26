//
//  四种Subject的基本用法.swift
//  BasicTerm
//
//  Created by Song Zixin on 2020/1/26.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import Foundation
import RxSwift

let subject = PublishSubject<String>()

subject.onNext("Episode1 updated")



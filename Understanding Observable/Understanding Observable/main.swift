//
//  main.swift
//  Understanding Observable
//
//  Created by Song Zixin on 2020/1/28.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import Foundation
import RxSwift

let emptySequence = Observable<Int>.empty()

emptySequence.subscribe { event in
    print(event)
}

_ = Observable.generate(initialState: 0, condition: { $0 < 10 }, iterate: { $0 + 1 }
).subscribe {
    print($0)
}



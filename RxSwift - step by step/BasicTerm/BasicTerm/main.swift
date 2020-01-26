//
//  main.swift
//  BasicTerm
//
//  Created by Song Zixin on 2019/10/6.
//  Copyright © 2019 Song Zixin. All rights reserved.
//

import RxSwift
import Foundation

//var evenNumberObservable = Observable.of("1","2","3","4","5","6","7","8").map { Int($0) }
//    .filter {
//        if let item = $0, item % 2 == 0 {
//            print("Even: \(item)")
//            return true
//        }
//
//        return false
//}
//
//evenNumberObservable.skip(2).subscribe { event in
//    print("Event: \(event)")
//}

//Boxue Code

//public func delay(_ delay: Double, closure: @escaping () -> Void) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//        closure()
//    }
//}


//let disposable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).subscribe(
//    onNext: { print("Subscribed: \($0)") },
//    onDisposed: { print("The queue was disposed.") })
//
//delay(5) {
//    disposable.dispose()
//}
//
////为了让它可以一直emit事件，最后，我们调用了dispatchMain让程序保持不退出


//var bag = DisposeBag()
//
//Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).subscribe(
//    onNext: { print("Subscribed: \($0)") },
//    onDisposed: { print("The queue was disposed") })
//.disposed(by: bag)
//
//delay(5) {
//    bag = DisposeBag()
//}
//
//dispatchMain()

//RxSwift Code

//let scheduler = SerialDispatchQueueScheduler(qos: .default)
//let subscription = Observable<Int>.interval(.seconds(1), scheduler: scheduler)
//    .subscribe (
//      onNext: { print("Subscribed: \($0)") },
//      onDisposed: { print("The queue was disposed.") }
//)
//
//Thread.sleep(forTimeInterval: 5.0)
//
//subscription.dispose()


enum CustomError: Error {
    case somethingWrong
}


let customOb = Observable<Int>.create { observer in
    observer.onNext(10)
    
    observer.onError(CustomError.somethingWrong)
    observer.onNext(11)
    
    observer.onCompleted()
    
    return Disposables.create()
}

let disponseBag = DisposeBag()

//customOb.do (
//    onNext: { print("Intercepted: \($0)") },
//    onError: { print("Intercepted: \($0)") },
//    onCompleted: { print("Intercepted: Completed") },
//    onDispose: { print("Intercepted: Game over!") }
//)
//
//.subscribe(
//    onNext: { print($0) },
//    onError: { print($0) },
//    onCompleted: { print("Completed") },
//    onDisposed: { print("Game over") }
//).disposed(by: disponseBag)

customOb.debug()
.subscribe(
    onNext: { print($0) },
    onError: { print($0) },
    onCompleted: { print("Completed") },
    onDisposed: { print("Game over") }
).disposed(by: disponseBag)


//
//  MyRxTableViewDelegateProxy.swift
//  RxNetworkDemo
//
//  Created by Song Zixin on 2020/2/8.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MyRxTableViewDelegateProxy: DelegateProxy<UITableView, UITableViewDelegate>, UITableViewDelegate, DelegateProxyType {
    static func registerKnownImplementations() {
        self.register {
            MyRxTableViewDelegateProxy(parentObject: $0, delegateProxy: MyRxTableViewDelegateProxy.self) }
    }
    
    static func currentDelegate(for object: UITableView) -> UITableViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: UITableViewDelegate?, to object: UITableView) {
        object.delegate = delegate
    }
}

private extension Selector {
    static let didSelectRowAt =
        #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
}

extension UITableView {
    var rxDelegate: MyRxTableViewDelegateProxy {
        return MyRxTableViewDelegateProxy.proxy(for: self)
    }
    
    var rxDidSelectRowAtIndexPath: Observable<(UITableView, IndexPath)> {
//        return rxDelegate.methodInvoked(#selector(UITableViewDelegate.tableView(_:didSelectRowAt:))) .map{ params in
//            return (params[0] as! UITableView, params[1] as! IndexPath)
        return rxDelegate.methodInvoked(.didSelectRowAt).map { params in
            return (params[0] as! UITableView, params[1] as! IndexPath)
        }
    }
}


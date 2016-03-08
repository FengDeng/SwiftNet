//: Playground - noun: a place where people can play

import UIKit
import RxSwift




func mmmm(m:Bool)->Observable<Bool>{
    let a = Observable.just(m)
    
    return a.concat(Observable.never()).throttle(1, scheduler: MainScheduler.instance).take(1)
}

mmmm(false).subscribeNext { (aa) -> Void in
    print(aa)
}
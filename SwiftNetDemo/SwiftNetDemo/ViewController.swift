//
//  ViewController.swift
//  SwiftNetDemo
//
//  Created by 邓锋 on 16/2/29.
//  Copyright © 2016年 fengdeng. All rights reserved.
//

import UIKit
import SwiftNet
import Alamofire
import RxSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        Request(url: "https://api.github.com/users/FengDeng")
        //            .beforeValidate({print("验证前先配置一些东西哈")})
        //            .validate({throw NSError(domain: "validate error", code: -1, userInfo: nil)})
        //            .beforeRequest({print("我要请求啦")})
        //            .responseJSON(User)
        //            .subscribeNext { (user) -> Void in
        //                print(user.avatar_url)
        //        }
        //        
        //        Request(url: "https://api.github.com/users/FengDeng").responseJSON(User).subscribeNext { (user) -> Void in
        //            print(user.avatar_url)
        //        }
        //        
        //        Request(config: SwiftNetConfigImp()).responseJSON(User).subscribeNext { (user) -> Void in
        //            print(user.avatar_url)
        //        }
        
        Observable.combineLatest(Request(url: "https://api.github.com/users/FengDeng").responseJSON(User), Request(url: "https://api.github.com/users/tangqiaoboy").responseJSON(User)) { (user1, user2) -> User in
            let user  = User()
            user.avatar_url = user1.avatar_url + user2.avatar_url
            return user
            }.subscribe { (event) -> Void in
                switch event{
                case .Completed:
                    print("com")
                case .Next(let user):
                    print(user.avatar_url)
                case .Error(let error):
                    print(error)
                }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


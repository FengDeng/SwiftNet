//
//  File.swift
//  SwiftNetDemo
//
//  Created by 邓锋 on 16/3/8.
//  Copyright © 2016年 fengdeng. All rights reserved.
//

import Foundation

class User : ModelJSONType{
    
    var username = ""
    var avatar_url = ""
    
    required init(){}
    
    static func from(json: AnyObject?) throws -> Self {
        guard let json = json as? [String:AnyObject] else{
            throw NSError(domain: "json 解析出错", code: -1, userInfo: nil)
        }
        let user = User()
        user.avatar_url = (json["avatar_url"] as? String) ?? ""
        return autocast(user)
    }
}
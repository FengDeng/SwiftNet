//
//  SwiftNetConfigImp.swift
//  SwiftNetDemo
//
//  Created by 邓锋 on 16/3/8.
//  Copyright © 2016年 fengdeng. All rights reserved.
//

import Foundation
import Alamofire

class SwiftNetConfigImp : SwiftNetConfig {
    var method : Alamofire.Method {return .GET}
    var url : URLStringConvertible {return "https://api.github.com/users/FengDeng"}
    var parameters : [String: AnyObject]? {return nil}
    var encoding: ParameterEncoding {return .URL}
    var headers: [String: String]? {return nil}
    
}
//
//  AKNetworkConfig.swift
//  IaskuNetwork
//
//  Created by 邓锋 on 16/3/4.
//  Copyright © 2016年 iasku. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

/**
 *  离散型的API设计 必须符合此协议
 */
public protocol SwiftNetConfig{
    var method : Alamofire.Method {get}
    var url : URLStringConvertible {get}
    var parameters : [String: AnyObject]? {get}
    var encoding: ParameterEncoding {get}
    var headers: [String: String]? {get}
}


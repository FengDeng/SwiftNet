//
//  ModelType.swift
//  SwiftNetDemo
//
//  Created by 邓锋 on 16/3/7.
//  Copyright © 2016年 fengdeng. All rights reserved.
//

import Foundation

//返回Self
func autocast<T>(x: Any) -> T {
    return x as! T
}

public protocol ModelJSONType{
    //从JSON转化
    static func from(json:AnyObject?) throws -> Self
}

public protocol ModelStringType{
    //从String转化
    static func from(string:String?) throws ->Self
}

public protocol ModelDataType{
    //从Data转化
    static func from(data:NSData?) throws ->Self
}

public protocol ModelDefaultType{
    //默认
    static func from(request:NSURLRequest?, response:NSHTTPURLResponse?, data:NSData?) throws ->Self
}

public protocol ModelPropertyListType{
    //PropertyList
    static func from(propertyList:AnyObject?) throws ->Self
}
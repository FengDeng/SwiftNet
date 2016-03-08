//
//  Request.swift
//  IaskuNetwork
//
//  Created by 邓锋 on 16/3/4.
//  Copyright © 2016年 iasku. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public class Request{
    
    //public typealias Success = O->Void
    public typealias Failure = ErrorType ->Void
    
    //generate request
    //Method
    //public typealias setMethod = Void ->Alamofire.Method
    private var method : Alamofire.Method = Alamofire.Method.GET
    
    //url
    //public typealias setURL = Void ->URLStringConvertible
    private var url : URLStringConvertible
    
    //parameters
    //public typealias setParameters = Void ->[String: AnyObject]?
    private var parameters : [String: AnyObject]?
    
    //encoding
    //public typealias setEncoding = Void ->ParameterEncoding
    private var encoding: ParameterEncoding = .URL
    
    //headers
    //public typealias setHeaders = Void ->[String: String]?
    private var headers: [String: String]?
    
    //timeout
    //public typealias setTimeoutInterval = Void ->NSTimeInterval
    private var timeoutInterval : NSTimeInterval = 20
    
    private var config = true
    
    
    //request life
    //beforeValidate
    public typealias setBeforeValidate = Void throws ->()
    var beforeValidate : setBefore?
    
    //validate
    public typealias setValidate = Void throws ->()
    var validate : setValidate = {}
    
    //before
    public typealias setBefore = Void throws ->()
    var beforeRequest : setBefore?
    
    public init(config:SwiftNetConfig){
        self.url = config.url
        self.method = config.method
        self.parameters = config.parameters
        self.encoding = config.encoding
        self.headers = config.headers
    }
    
    public init(url:URLStringConvertible){
        self.url = url
    }
    
    convenience public init(method:Alamofire.Method,url:URLStringConvertible){
        self.init(url:url)
        self.method = method
    }
    
    deinit{
        print("Request deinit")
    }
    
    
}

// MARK: - Request Parameters
extension Request{
    //setting
    func method(method:Alamofire.Method)->Self{
        self.method = method
        return self
    }
    
    func parameters(parameters:[String: AnyObject])->Self{
        self.parameters = parameters
        return self
    }
    
    func encoding(encoding:ParameterEncoding)->Self{
        self.encoding = encoding
        return self
    }
    
    func headers(headers:[String: String])->Self{
        self.headers = headers
        return self
    }
    
    func config(config:Bool)->Self{
        self.config = config
        return self
    }
    
}


// MARK: - Life Circle
extension Request{
    //life
    func beforeValidate(beforeValidate:setBefore)->Self{
        self.beforeValidate = beforeValidate
        return self
    }
    
    func validate(validate:setValidate)->Self{
        self.validate = validate
        return self
    }
    
    func beforeRequest(beforeRequest:setBefore)->Self{
        self.beforeRequest = beforeRequest
        return self
    }
}

// MARK: - JSON
extension Request{
    func responseJSON<K : ModelJSONType>(modelClass:K.Type)->Observable<K>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responseJSON(completionHandler: { res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                do{
                    let k = try K.from(res.result.value)
                    observer.onNext(k)
                    observer.onCompleted()
                }catch{
                    observer.onError(error)
                }
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
    
    func responseJSON()->Observable<AnyObject?>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responseJSON(completionHandler: { res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                observer.onNext(res.result.value)
                observer.onCompleted()
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
}

// MARK: - String
extension Request{
    func responseString<K : ModelStringType>(modelClass:K.Type,encoding:NSStringEncoding? = nil)->Observable<K>{
        return Observable.create({ /*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responseString(encoding: encoding, completionHandler: { res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                do{
                    let k = try K.from(res.result.value)
                    observer.onNext(k)
                    observer.onCompleted()
                }catch{
                    observer.onError(error)
                }
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
    func responseString(encoding:NSStringEncoding? = nil)->Observable<String?>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responseString(encoding: encoding, completionHandler: { res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                observer.onNext(res.result.value)
                observer.onCompleted()
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
}

// MARK: - Data
extension Request{
    func responseData<K : ModelDataType>(modelClass:K.Type)->Observable<K>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responseData({ res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                do{
                    let k = try K.from(res.result.value)
                    observer.onNext(k)
                    observer.onCompleted()
                }catch{
                    observer.onError(error)
                }
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
    
    func responseData()->Observable<NSData?>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responseData({ res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                observer.onNext(res.result.value)
                observer.onCompleted()
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
}

// MARK: - Default Response
extension Request{
    func response<K : ModelDefaultType>(modelClass:K.Type)->Observable<K>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.response(completionHandler: { (re, res, data, error) -> Void in
                if let error = error {
                    observer.onError(error)
                }
                do{
                    let k = try K.from(re, response: res, data: data)
                    observer.onNext(k)
                    observer.onCompleted()
                }catch{
                    observer.onError(error)
                }
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
    
    func response()->Observable<(NSURLRequest?, NSHTTPURLResponse?, NSData?)>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.response(completionHandler: { (re, res, data, error) -> Void in
                if let error = error {
                    observer.onError(error)
                }
                observer.onNext((re,res,data))
                observer.onCompleted()
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
}

// MARK: - PropertyList
extension Request{
    func responsePropertyList<K : ModelPropertyListType>(modelClass:K.Type,options:NSPropertyListReadOptions = NSPropertyListReadOptions())->Observable<K>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responsePropertyList(options: options, completionHandler:{ res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                do{
                    let k = try K.from(res.result.value)
                    observer.onNext(k)
                    observer.onCompleted()
                }catch{
                    observer.onError(error)
                }
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
    
    func responsePropertyList(options:NSPropertyListReadOptions = NSPropertyListReadOptions())->Observable<AnyObject?>{
        return Observable.create({/*[weak /*weakSelf*/self = self]*/ observer -> Disposable in
            /*guard let /*weakSelf*/self = /*weakSelf*/self else {
            observer.on(.Completed)
            return NopDisposable.instance
            }*/
            //validata
            do{
                try /*weakSelf*/self.beforeValidate?()
                try /*weakSelf*/self.validate()
                try /*weakSelf*/self.beforeRequest?()
                
            }catch{
                observer.onError(error)
            }
            let re =  request(/*weakSelf*/self.method, /*weakSelf*/self.url, parameters: /*weakSelf*/self.parameters, encoding: /*weakSelf*/self.encoding, headers: /*weakSelf*/self.headers)
            re.responsePropertyList(options: options, completionHandler:{ res -> Void in
                if let error = res.result.error {
                    observer.onError(error)
                }
                observer.onNext(res.result.value)
                observer.onCompleted()
            })
            return AnonymousDisposable{
                re.cancel()
            }
        })
    }
}

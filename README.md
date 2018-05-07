# SwiftNet
直接可用的Swift 网络库。


###没想到还有人用的。这个不维护了。新建链接可以看看
[CNNetwork](https://github.com/FengDeng/CNNetwork)


##Request

采用链式调用配置Request
	
		Request(url: "https://api.github.com/users/FengDeng").method(.GET).parameters(["":""]).headers(["":""])……
		
请求前参数验证

		Request(url: "https://api.github.com/users/FengDeng")
            .beforeValidate({print("验证前先配置一些东西哈")})
            .validate({throw NSError(domain: "validate error", code: -1, userInfo: nil)})
            .beforeRequest({print("我要请求啦")})
            .responseJSON(User)
            .subscribeNext { (user) -> Void in
                print(user.avatar_url)
        }	
        
        
所有的闭包都可以直接抛出异常，一直走到Response的error里处理

##为什么返回Observable。
####处理多请求同时返回

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
        
这里就是两个用户都获取到才会调用下面的方法。这是RxSwift里的特性了。因为这里返回了Observable对象，所以很多特性都可以使用	

等等
		
##可用于两种API设计		


1. 集约型API设计
		
		Request(url: "https://api.github.com/users/FengDeng").responseJSON().subscribeNext { (json) -> Void in
            if let json = json{
                print(json)
            }
        }

2. 离散型API设计

	首先创建一个符合 SwiftNetConfig 协议的类或结构体
	
	使用此类的实例来初始化Request
		
		//离散型的文件
		class SwiftNetConfigImp : SwiftNetConfig {
    		var method : Alamofire.Method {return .GET}
    		var url : URLStringConvertible {return "https://api.github.com/users/FengDeng"}
    		var parameters : [String: AnyObject]? {return nil}
    		var encoding: ParameterEncoding {return .URL}
    		var headers: [String: String]? {return nil}
    
		}
		
		//请求
		Request(config: SwiftNetConfigImp()).responseJSON(User).subscribeNext { (user) -> Void in
            print(user.avatar_url)
        }
        
        
        
        
##Response

返回值参考Alamofire设计 也调用Alamofire的接口。

返回JSON，Data，String等等，全部包装成Observable类以供订阅

也可以在返回的同时进行Model化。参考项目中的demo。至于您选择YYModel，MJExtension，SwiftJSON，Argo等等都可以

###Model转化

	responseJSON(User)->Observable<User>
	
	等等

此处的User类需要实现ModelJSONType协议

###不使用Model转化

	responseJSON()->Observable<AnyObject?>
	
	
##Cocoapods

	pod 'SwiftNet', git: 'https://github.com/FengDeng/SwiftNet.git'

##使用的第三方库
	
[RxSwift](https://github.com/ReactiveX/RxSwift)
	
[Alamofire](https://github.com/Alamofire/Alamofire)
	
感谢RxSwift 和 Alamofire

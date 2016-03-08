Pod::Spec.new do |s|
s.name = 'SwiftNet'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = '项目可直接使用的网络请求库'
s.author  = { "邓锋" => "704292743@qq.com" }
s.homepage = 'https://github.com/FengDeng/SwiftNet'
s.source = { :git => 'https://github.com/FengDeng/SwiftNet.git', :tag => s.version }

s.ios.deployment_target = '8.0'

s.source_files = 'SwiftNet/SwiftNet/*.swift'

s.dependency 'Alamofire', '~> 3.1.3'
s.dependency 'RxSwift', '~> 2.2.0'

end

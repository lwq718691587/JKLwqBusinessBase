Pod::Spec.new do |s|
s.name             = 'JKLwqBusinessBase'
s.version          = '1.0.0'
s.summary          = '业务基础模块'
s.homepage         = 'https://github.com/lwq718691587/JKLwqBusinessBase'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'liuweiqiang' => '718691587@qq.com' }
s.source           = { :git => 'https://github.com/lwq718691587/JKLwqBusinessBase.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.dependency 'JKUIBaseKit'
s.dependency 'JKBaseKit'
s.dependency 'JKNetWorking'


s.source_files = 'JKLwqBusinessBase/Classes/**/*.{h,m}'


s.resource_bundles = {
'JKBusinessBase' => ['JKLwqBusinessBase/Assets/*.{png,plist}','JKLwqBusinessBase/Classes/**/*.xib']
}


end


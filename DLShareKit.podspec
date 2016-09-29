Pod::Spec.new do |s|
  	s.name         = 'DLShareKit'
    s.version      = '0.1.1'
    s.summary      = 'iOS 分享组件'
    s.homepage     = 'https://github.com/ZengyiMa/DLShareKit'
    s.license      = 'MIT'
    s.authors      = {'MaZengyi' => 'semazengyi@gmail.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/ZengyiMa/DLShareKit.git', :tag => s.version}
    s.source_files = 'DLShareKit/*.{h,m}'
    s.frameworks = "SystemConfiguration", "ImageIO", "CoreTelephony"
    s.libraries = "stdc++", "sqlite3", "z"
    s.requires_arc = true


 s.subspec 'Weibo' do |weibo|
    weibo.source_files = "DLShareKit/Weibo/*.{h,m}"
    weibo.resources = "Sources/Weibo/*.bundle"
    weibo.vendored_libraries = "DLShareKit/Weibo/*.a"
  end

  s.subspec 'Wechat' do |wechat|
    wechat.source_files = "DLShareKit/Wechat/*.{h,m}"
    wechat.vendored_libraries = "DLShareKit/Wechat/*.a"
  end

  s.subspec 'Tencent' do |tencent|
    tencent.source_files = "DLShareKit/Tencent/*.{h,m}"
    tencent.vendored_frameworks = "DLShareKit/Tencent/TencentOpenAPI.framework"
  end



end



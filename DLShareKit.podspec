Pod::Spec.new do |s|
  	s.name         = 'DLShareKit'
    s.version      = '0.1.0'
    s.summary      = 'iOS 分享组件'
    s.homepage     = 'https://github.com/ZengyiMa/DLShareKit'
    s.license      = 'MIT'
    s.authors      = {'MaZengyi' => 'semazengyi@gmail.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/ZengyiMa/DLShareKit.git', :tag => s.version}
    s.source_files = 'DLShareKit/DLShareKit/*.{h,m}'
    s.requires_arc = true
end
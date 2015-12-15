
Pod::Spec.new do |s|

  s.name         = "SZQRCodeCoverView"

  s.version      = "0.0.1"

  s.summary      = "qrcode cover view"

  s.homepage     = "https://github.com/chenshengzhi/SZTabSwitchBar"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "陈圣治" => "csz2136@163.com" }

  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/chenshengzhi/SZTabSwitchBar.git", :tag => s.version.to_s }

  s.source_files = "SZTabSwitchBar/*.{h,m}"

  s.requires_arc = true

  s.dependency 'SZFrameHelper'

end

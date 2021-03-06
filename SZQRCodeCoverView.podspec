
Pod::Spec.new do |s|

  s.name         = "SZQRCodeCoverView"

  s.version      = "0.0.6"

  s.summary      = "qrcode cover view"

  s.homepage     = "https://github.com/chenshengzhi/SZQRCodeCoverView"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "陈圣治" => "329012084@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/chenshengzhi/SZQRCodeCoverView.git", :tag => s.version.to_s }

  s.source_files = "SZQRCodeCoverView/*.{h,m}"

  s.requires_arc = true

end

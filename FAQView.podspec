Pod::Spec.new do |s|

  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.name         = "FAQView"
  s.version      = "0.3.0"
  s.summary      = "An easy to use FAQ view for iOS written in Swift."
  s.homepage     = "https://github.com/mukeshthawani/FAQView"
  s.license      = "MIT"
  s.author             = { "Mukesh Thawani" => "mukesh9039@gmail.com" }
  s.resources    = "Source/**/*.xcassets"
  s.social_media_url   = "http://twitter.com/MukeshThawani"
  s.source       = { :git => "https://github.com/mukeshthawani/FAQView.git", :tag => "#{s.version}" }
  s.framework  = "UIKit"
  s.source_files = "Source/*.swift"
  s.requires_arc = true
end

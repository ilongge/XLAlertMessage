#
# Be sure to run `pod lib lint XLAlertMessage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XLAlertMessage'
  s.version          = '0.0.3.1'
  s.summary          = 'A short description of XLAlertMessage.'

  s.homepage         = 'https://gitee.com/ilongge/xlalertmessage'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ilongge' => '1015820857@qq.com' }
  s.source           = { :git => 'https://gitee.com/ilongge/xlalertmessage.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'XLAlertMessage/**/*'
  s.public_header_files = 'XLAlertMessage/*.h'
  s.frameworks = 'UIKit', 'Foundation'
end

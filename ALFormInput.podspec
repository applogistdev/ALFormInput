#
# Be sure to run `pod lib lint ALFormInput.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ALFormInput'
  s.version          = '0.2.2'
  s.summary          = 'Commonly used form inputs in our projects'

  s.homepage         = 'https://github.com/applogistdev/ALFormInput'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ahmetsina' => 'ahmet.sina@applogist.com' }
  s.source           = { :git => 'https://github.com/applogistdev/ALFormInput.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.3'

  s.source_files = 'ALFormInput/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'SkyFloatingLabelTextField', '~> 3.0'
  s.dependency 'PhoneNumberKit', '~> 3.1'
  s.dependency 'SwiftValidatorNew', '~> 4.2.0'
  s.dependency 'ActionSheetPicker-3.0', '2.4.2'
  s.dependency 'AlExtensions', '0.2.0'
  s.dependency 'FontAwesome.swift', '1.9.0'

end

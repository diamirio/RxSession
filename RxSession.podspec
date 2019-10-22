#
# Be sure to run `pod lib lint RxWebSocket.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxSession'
  s.version          = '1.0.0'
  s.summary          = 'Rx Session to use with Endpoints.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Rx Session to use with Endpoints. That's it...
                       DESC

  s.homepage         = 'https://github.com/oanhof'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dominik Arnhof' => 'da@tailored-apps.com', 'Mario Hahn' => 'mh@tailored-apps.com' }
  s.source           = { :git => 'https://github.com/tailoredmedia/RxSession.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'
  s.osx.deployment_target = "10.11"

  s.source_files = 'RxSession/**/*.swift'
  s.swift_version = '5.0'

  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'Endpoints', '~> 2.0'

  s.test_spec 'Tests' do |test_spec|
    test_spec.ios.deployment_target = '9.0'
    test_spec.tvos.deployment_target = '9.0'
    test_spec.osx.deployment_target = '10.11'
    test_spec.source_files = 'RxSessionTests/**/*.swift'
  end
end

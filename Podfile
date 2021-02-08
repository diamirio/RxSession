# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

def common_pods
  pod 'RxSwift', '~> 6.0'
  pod 'RxCocoa', '~> 6.0'
  pod 'Endpoints', '~> 2.0'
end

target 'RxSession' do
  common_pods
  
  target 'RxSessionTests' do
    inherit! :search_paths
  end
end

target 'RxSessionExample' do
    inherit! :search_paths
    common_pods
end


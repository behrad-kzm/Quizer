# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def rx_swift
  pod 'RxSwift', '~> 4.0'
end

def rx_cocoa
  pod 'RxCocoa', '~> 4.0'
end

target 'Quizer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_cocoa
  rx_swift
  pod 'RxDataSources', '~> 3.0'
  pod 'lottie-ios'
  pod 'KDCircularProgress'
  pod 'NVActivityIndicatorView'
  # Pods for Quizer

end
target 'Domain' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  
end

target 'NetworkPlatform' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  pod 'Alamofire'
  pod 'RxAlamofire'
  
end

# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
source 'https://github.com/CocoaPods/Specs.git'
#source 'https://github.com/thridparty-cloud2/QuecPublicSpecs.git'
source 'ssh://git@gitlab.quectel.com:8061/frontend/QuecPublicSpecs.git'

def commpod
  pod 'Toast', '~> 4.0.0'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SDWebImage', '~> 5.11.1'
  pod 'BRPickerView'
  pod 'Masonry'
  pod 'IQKeyboardManager'
end

target 'QuecIoTAppSdkDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  
  commpod
  # Pods for QuecIoTAppSdkDemo
  # IotSdk Manager All OpenKit
  
#  pod 'MQTTClient' , '~> 0.15.4'

  pod 'QuecIotSdk', '2.0.0'
  
  pod 'QuecSmartHomeKit', '~> 2.1.0'
  pod 'QuecSceneKit', '~> 0.4.0'
  pod 'QuecAutomateKit', '~> 0.3.0'
  pod 'QuecGroupKit', '~> 0.5.0'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        
        config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
        config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
        config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      end
    end
    
  end
  target 'QuecIoTAppSdkDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'QuecIoTAppSdkDemoUITests' do
    # Pods for testing
  end
  
end







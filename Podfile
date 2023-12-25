# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/thridparty-cloud2/QuecPublicSpecs.git'
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
  pod 'QuecIotSdk' , '~> 1.10.0'
  
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

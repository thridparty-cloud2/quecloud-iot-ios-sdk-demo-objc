
<!--# quec-app-advanced-baidu-map-->

## Quec iOS IoTSDK Demo for Objective-C
</br>

#### 此demo演示如何使用QuecIoTAppSDK从头开始构建物联网应用程序。QuecIoTAppSDK分为几个功能组，让开发人员清楚地了解不同功能的实现，包括用户注册过程、设备绑定和控制、设备群组设置。可绑定蜂窝设备或者WIFI/蓝牙设备。对于设备控制，可基于HTTP和WebSocket进行控制。


### 要求
- Xcode 12.0 及更高版本
- iOS 12 及更高版本


### 使用

#### 1. 此demo依赖 CocoaPods，若未安装，可执行以下指令安装
```
sudo gem install cocoapods
pod setup
```

#### 2. 克隆或者下载此demo，进入到项目包含Podfile的文件夹
```
pod install
```

#### 3.  此demo需要在[移远云平台](https://iot-cloud.quectel.com/)注册开发者账号，并获取userDomain和userDomainSecret

#### 4. 打开 QuecIoTAppSdkDemo.xworkspace

#### 5.  替换AppDelegate中SDK初始化方法的userDomain和userDomainSecret

```
   [[QuecIoTAppSDK sharedInstance] startWithUserDomain:@"your user domain XXX" userDomainSecret:@"your user domain secret XXX" cloudServiceType:XXX];
```
### 参考
关于移远云IoTSDK的更多信息，请参见[API](https://github.com/thridparty-cloud2/quecloud-iot-ios-sdk-demo-objc/blob/master/API.md)。
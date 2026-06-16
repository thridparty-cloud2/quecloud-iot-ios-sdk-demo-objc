## Quec iOS IoTSDK Demo for Objective-C
</br>

> 📖 中文文档请参阅 [README_zh.md](./README_zh.md)

#### This demo illustrates how to build an IoT application from scratch using QuecIoTAppSDK. QuecIoTAppSDK is divided into several functional groups, giving developers a clear understanding of the implementation of different features, including user registration, device binding and control, and device group management. Both cellular devices and Wi-Fi/Bluetooth devices can be bound. For device control, both HTTP and WebSocket are supported.


### Requirements
- Xcode 13 or later
- iOS 14 or later


### Usage

#### 1. This demo depends on CocoaPods. If not installed, run the following commands to install it:
```
sudo gem install cocoapods
pod setup
```

#### 2. Clone or download this demo, then navigate to the folder containing the Podfile and run:
```
pod install
```

#### 3. A developer account is required on the [Quectel Cloud Platform](https://aiot.quectel.com/). Obtain your `userDomain` and `userDomainSecret` from the platform.

#### 4. Open `QuecIoTAppSdkDemo.xcworkspace`

#### 5. Fill in the `userDomain` and `userDomainSecret` configuration in `LoginViewController`, then select the corresponding data center after launch:

```
   static NSString * const UserDomainCN = @"";
   static NSString * const UserSecretCN = @"";
   static NSString * const UserDomainEU = @"";
   static NSString * const UserSecretEU = @"";
   static NSString * const UserDomainNA = @"";
   static NSString * const UserSecretNA = @"";
```

//
//  MacroDefine.h
//  QuecIoTAppSdkDemo
//
//  Created by quectel.tank on 2022/3/30.
//

#ifndef MacroDefine_h
#define MacroDefine_h

#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen] bounds].size.height

#define QuecWeakSelf(type)  __weak typeof(type) weak##type = type;
#define QuecStrongSelf(type) __strong typeof(type) type = weak##type;

#endif /* MacroDefine_h */

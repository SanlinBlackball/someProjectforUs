//
//  Constant.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#define kUseSimulatedData 0
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS


//    系统控件的默认高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define kStatusBarHeight   (20.f)
#define kTopBarHeight      (44.f)
#define kNavigationBar     (64.f)
#define kBottomBarHeight   (49.f)

#define LYGlobalBg RGB(243, 245, 249)

#endif /* Constant_h */

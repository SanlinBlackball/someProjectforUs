//
//  UIViewController+SystemBackButtonHandler.h
//  SZBBS
//
//  Created by 朱标 on 16/8/9.
//  Copyright © 2016年 Seentao Technology CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
//拦截了系统返回按钮的点击事件
-(BOOL)navigationShouldPopOnBackButton;
@end
@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>
@end
//
//  CustomTabBar.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTabBar;
@protocol CustomTarBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidPlusClick:(CustomTabBar *)tarbar;
@end

@interface CustomTabBar : UITabBar
@property (nonatomic, weak) id<CustomTarBarDelegate> delegate;
//中心文字
@property (nonatomic, strong) NSString * centerStr;
//中心选中图片
@property (nonatomic, strong)NSString *selectImageStr;
//中心平常图片
@property (nonatomic, strong)NSString *normalImageStr;
//中心选中文字颜色
@property (nonatomic, strong)UIColor *selectColor;
//中心平常文字颜色
@property (nonatomic, strong)UIColor *normalColor;
@end

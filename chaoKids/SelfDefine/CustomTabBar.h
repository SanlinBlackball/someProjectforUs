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
@property (nonatomic, strong) NSString * centerStr;
@property (nonatomic, strong)NSString *selectImageStr;
@property (nonatomic, strong)NSString *normalImageStr;
@property (nonatomic, strong)UIColor *selectColor;
@property (nonatomic, strong)UIColor *normalColor;
@end

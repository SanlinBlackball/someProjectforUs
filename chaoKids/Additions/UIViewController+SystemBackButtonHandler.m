//
//  UIViewController+SystemBackButtonHandler.m
//  SZBBS
//
//  Created by 朱标 on 16/8/9.
//  Copyright © 2016年 Seentao Technology CO.,LTD. All rights reserved.
//

#import "UIViewController+SystemBackButtonHandler.h"

@implementation UIViewController (BackButtonHandler)

@end
//.扩展UINavigationController ,也可以继承 使用

@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem*)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;  
                }];  
            }  
        }  
    }  
    
    return NO;  
}  

@end

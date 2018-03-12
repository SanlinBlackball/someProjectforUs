//
//  UIViewController+STTShowLoading.h
//  SZBBS
//
//  Created by AngusChen on 15/10/22.
//  Copyright © 2015年 Seentao Technology CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(STTShowLoading)
/**
 *  加载中动画开启，停止
 *  TODO:实现
 */
- (void)startLoadingAnimation;
- (void)startLoadingAnimationWithText:(NSString *)text;
- (void)startLoadingAnimationWithProgress:(NSProgress *)progress;
- (void)stopLoading;

@end

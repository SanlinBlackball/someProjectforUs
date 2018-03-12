//
//  UIImageAdditions.h
//  SZBBS
//
//  Created by AngusChen on 15/11/16.
//  Copyright © 2015年 Seentao Technology CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(STTImageWithColor)
/**
 *  使用颜色生成UIImage对象
 *
 *  @param color 颜色
 *  @param size  UIImage需要的size
 *
 *  @return UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                    andSize:(CGSize)size;

@end


@interface UIImage (STTScaleImageToSize)
- (UIImage*)imageScaledToSize:(CGSize)newSize;
@end
//
//  UIImageAdditions.m
//  SZBBS
//
//  Created by AngusChen on 15/11/16.
//  Copyright © 2015年 Seentao Technology CO.,LTD. All rights reserved.
//

#import "UIImageAdditions.h"

@implementation UIImage(STTImageWithColor)
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRect:rect];
    
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation UIImage (STTScaleImageToSize)

//对图片尺寸进行压缩--
- (UIImage*)imageScaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end



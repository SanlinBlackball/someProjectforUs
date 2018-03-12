//
//  UIViewController+BackBtn.m
//  SZBBS
//
//  Created by 朱标 on 16/8/29.
//  Copyright © 2016年 Seentao Technology CO.,LTD. All rights reserved.
//

#import "UIViewController+BackBtn.h"

@implementation UIViewController (BackBtn)
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewDidLoad
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:nil];
}
@end

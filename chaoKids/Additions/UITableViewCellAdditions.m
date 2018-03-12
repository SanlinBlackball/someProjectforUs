//
//  UITableViewCellAdditions.m
//  SZBBS
//
//  Created by AngusChen on 15/11/19.
//  Copyright © 2015年 Seentao Technology CO.,LTD. All rights reserved.
//

#import "UITableViewCellAdditions.h"

@implementation UITableViewCell(STTEnumTableView)

- (UITableView *)tableView {
    UIView *tableView = self.superview;
    
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    
    return (UITableView *)tableView;
}

@end

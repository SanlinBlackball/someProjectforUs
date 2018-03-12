//
//  CustomTabBar.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "CustomTabBar.h"
#import "UIViewAdditions.h"

#define AddButtonMargin 10
#define  ControllCount 4
@interface CustomTabBar ()
@property (nonatomic, weak) UIButton *centerButton;
@property (nonatomic, weak) UILabel *centerLabel;
@end
@implementation CustomTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //去除顶部很丑的border
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new]];
        //自定义分割线颜色
        // 添加加好按钮
        UIButton *centerButton = [[UIButton alloc] init];
        [centerButton setImage:[[UIImage imageNamed:@"tab_publish_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        // 设置监听事件
        [centerButton addTarget:self action:@selector(onCenterButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.centerButton = centerButton;
        [self addSubview:centerButton];
        
        UILabel *centerLabel = [[UILabel alloc] init];
       
        centerLabel.font = [UIFont systemFontOfSize:10];
        
        [centerLabel sizeToFit];
        [self addSubview:centerLabel];
        self.centerLabel = centerLabel;
    }
    return self;
}

- (void)onCenterButtonClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidPlusClick:)]) {
        [self.delegate tabBarDidPlusClick:self];
    }
}
-(void)setCenterStr:(NSString *)centerStr {
    _centerStr = centerStr;
   _centerLabel.text = _centerStr;
    [_centerLabel sizeToFit];
}
-(void)setSelectImageStr:(NSString *)selectImageStr {
    _selectImageStr = selectImageStr;
    [_centerButton setImage:[[UIImage imageNamed:_selectImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
}
-(void)setNormalImageStr:(NSString *)normalImageStr {
    _normalImageStr = normalImageStr;
    [_centerButton setImage:[[UIImage imageNamed:_normalImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}
- (void) setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    _centerLabel.textColor = normalColor;
}
- (void) setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    _centerLabel.textColor = _selectColor;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 计算宽度
    CGFloat childW = self.width / (ControllCount + 1);
    self.centerButton.width = childW;
    
    
    // 添加plusBtn的位置
    self.centerButton.left = ([UIScreen mainScreen].bounds.size.width - childW) * 0.5;
    self.centerButton.centerY = self.height * 0.5 - 1.5 * AddButtonMargin;
    self.centerLabel.centerX = self.centerButton.centerX;
    self.centerLabel.centerY = CGRectGetMaxY(self.centerButton.frame) + 0.5 * AddButtonMargin + 0.5;
    // 引出下标
    NSInteger index = 0;
    // 判断是否为控制器按钮
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child.class isSubclassOfClass:class]) {
            child.left = index * childW;
            child.width = childW;
            index++;
            if (index == 3) {
                self.centerButton.height = child.height;
                child.hidden = YES;
//                index ++;
            }
        }
    }
}
//重写hitTest方法，去监听"+"按钮和“添加”标签的点击，目的是为了让凸出的部分点击也有反应
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

     //这一个判断是关键，不判断的话push到其他页面，点击“+”按钮的位置也是会有反应的，这样就不好了
     //self.isHidden == NO 说明当前页面是有TabBar的，那么肯定是在根控制器页面
     //在根控制器页面，那么我们就需要判断手指点击的位置是否在“+”按钮或“添加”标签上
     //是的话让“+”按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
     if (self.isHidden == NO) {

         //将当前TabBar的触摸点转换坐标系，转换到“+”按钮的身上，生成一个新的点
         CGPoint newA = [self convertPoint:point toView:self.centerButton];
          //将当前TabBar的触摸点转换坐标系，转换到“添加”标签的身上，生成一个新的点
         CGPoint newL = [self convertPoint:point toView:self. centerLabel];

         //判断如果这个新的点是在“+”按钮身上，那么处理点击事件最合适的view就是“+”按钮
         if ( [self.centerButton pointInside:newA withEvent:event]) {
             return self.centerButton;
         }
         //判断如果这个新的点是在“添加”标签身上，那么也让“+”按钮处理事件
        else if([self.centerLabel pointInside:newL withEvent:event]) {
             return self.centerButton;
         }else {//如果点不在“+”按钮身上，直接让系统处理就可以了

             return [super hitTest:point withEvent:event];
        }
    }else {
         //TabBar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
         return [super hitTest:point withEvent:event];
     }
 }
@end

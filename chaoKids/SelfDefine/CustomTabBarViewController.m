//
//  CustomTabBarViewController.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "CustomTabBar.h"
#import "UIColor+RGBHelper.h"
@interface CustomTabBarViewController ()<CustomTarBarDelegate>

@end

@implementation CustomTabBarViewController

/**
 *  公共设置控制器方法
 *
 *  @param viewController 控制器
 *  @param title          底部Tabbar文字
 *  @param selectImageStr 底部Tabbar点击图片
 *  @param narmalImageStr 底部Tabbar普通图片
 *
 *  @return navigationController
 */
- (UINavigationController *)getNavigationController:(UIViewController *)viewController title:(NSString *)title selectImageStr:(NSString *)selectImageStr narmalImageStr:(NSString *)narmalImageStr {
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.title = title;
    nav.navigationBar.barTintColor = [UIColor colorIntegerWithRed:209 green:21 blue:24];
    NSDictionary *dic=@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [nav.navigationBar setTitleTextAttributes:dic];
    nav.tabBarItem.image = [[UIImage imageNamed:narmalImageStr]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    return nav;
    
}
- (UIViewController *)testViewController {
    UIViewController *vc = [[UIViewController alloc] init];
    return [self getNavigationController:vc title:@"首页" selectImageStr:@"tab_community_nor" narmalImageStr:@"tab_community_press"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建自定义TabBar
    CustomTabBar *customTabBar = [[CustomTabBar alloc] init];
    
    customTabBar.selectImageStr = @"tab_publish_nor";
    customTabBar.normalImageStr = @"tab_publish_nor";
    //    customTabBar.normalColor = [UIColor whiteColor];
    customTabBar.selectColor = [UIColor colorIntegerWithRed:209 green:21 blue:24];
    customTabBar.delegate = self;
    //利用KVC替换默认的TabBar
    [self setValue:customTabBar forKey:@"tabBar"];
    customTabBar.centerStr = @"中心";
    UIViewController *vc = [[UIViewController alloc] init];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:[self getNavigationController:vc title:@"首页" selectImageStr:@"tab_community_nor" narmalImageStr:@"tab_community_press"]];
    [self addChildViewController:[self getNavigationController:vc title:@"第二" selectImageStr:@"tab_community_nor" narmalImageStr:@"tab_community_press"]];
    [self addChildViewController:[self getNavigationController:vc2 title:@"第三" selectImageStr:@"tab_community_nor" narmalImageStr:@"tab_community_press"]];
    [self addChildViewController:[self getNavigationController:vc title:@"第四" selectImageStr:@"tab_community_nor" narmalImageStr:@"tab_community_press"]];
    [self addChildViewController:[self getNavigationController:vc title:@"第五" selectImageStr:@"tab_community_nor" narmalImageStr:@"tab_community_press"]];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //设置TabBar的TintColor
    //         self.tabBar.tintColor = [UIColor colorWithRed:89/255.0 green:217/255.0 blue:247/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyTabBarDelegate
- (void)tabBarDidPlusClick:(CustomTabBar *)tarbar {
    self.selectedIndex = 2;
}


@end

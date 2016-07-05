//
//  RootVcManager.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-8.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "RootVcManager.h"
#import "BaseNavigationViewController.h"
#import "BaseTabBarController.h"
#import "FindViewController.h"
#import "TReadingViewController.h"
#import "TListeningViewController.h"
#import "MineViewController.h"
@implementation RootVcManager
+(UIViewController *)mainVc
{
    
    NSArray * vcClassNames = @[@"FindViewController",@"TReadingViewController",@"TListeningViewController"];
    
   // NSArray * imageNames = @[@"tabbar_limitfree",@"tabbar_reduceprice",@"tabbar_appfree",@"tabbar_subject",@"tabbar_rank"];
    
    NSArray * titles = @[@"Ttravelling",@"Treading",@"Tlistening"];
    
    NSArray *array = @[@"飞t.png",@"阅读t.png",@"音乐t.png"];

    NSMutableArray * viewControllers = [NSMutableArray array];
    
    int i = 0;
    
    for (NSString * name in vcClassNames) {
        
        //创建对应的导航控制器
        UINavigationController * vc = [self navigationWithClass:NSClassFromString(name)];
        vc.automaticallyAdjustsScrollViewInsets = NO;
        //设置导航控制器当前显示的控制器的title
        vc.topViewController.title = titles[i];
        
        
        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:titles[i] image:[UIImage imageNamed:array[i]] tag:220+i];
        vc.tabBarItem = item;//设置Item

        [viewControllers addObject:vc];
        i ++;
        
    }
    
    
    
    UITabBarController * _tabVC = [[UITabBarController alloc] init];
    _tabVC.viewControllers = viewControllers;
    _tabVC.tabBar.tintColor = [UIColor colorWithRed:88/255.0 green:189/255.0 blue:36/255.0 alpha:1.0];
    
    return _tabVC;
}
+(UINavigationController *)navigationWithClass:(Class)vcClass{
    
    UIViewController * vc = [[vcClass alloc] init];
    
    BaseNavigationViewController * baseNaVC = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    return baseNaVC;
}
+(UIViewController *)getWindowRootVC{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    return  (UINavigationController *)delegate.window.rootViewController;
    
}

@end

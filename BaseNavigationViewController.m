//
//  BaseNavigationViewController.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-8.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
    self.navigationBar.tintColor = [UIColor colorWithRed:88/255.0 green:189/255.0 blue:36/255.0 alpha:1.0];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)createTabBar
{
    self.tabBarController.tabBar.hidden = YES;
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

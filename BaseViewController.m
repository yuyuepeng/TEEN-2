//
//  BaseViewController.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-8.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
       // Do any additional setup after loading the view.
}

-(MBProgressHUD *)hud{
    
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:_hud];//添加到视图上
    }
    
    return _hud;
    
}

-(void)startAnimationHud{
    
    //设置显示样式 菊花样式
    _hud.mode = MBProgressHUDModeIndeterminate;
    
    [self.hud show:YES];//显示菊花
    
}

-(void)stopHud{
    
    [self.hud hide:YES];//隐藏
    
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

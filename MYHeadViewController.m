//
//  MYHeadViewController.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-14.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "MYHeadViewController.h"

@interface MYHeadViewController ()

@end

@implementation MYHeadViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_pre_hl@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //NSLog(@"myurl%@",self.model.url);
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSString *urlStr = self.model.url;
    NSURL *url = [NSURL URLWithString:urlStr];

    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
   
    
    // Do any additional setup after loading the view from its nib.
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"wodeurl%@",self.headUrl);
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
//    NSString *urlStr = self.headUrl;
//    NSURL *url = [NSURL URLWithString:urlStr];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    webView.scalesPageToFit = YES;
//    [self.view addSubview:webView];
    // Do any additional setup after loading the view from its nib.
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

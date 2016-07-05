//
//  ReDetailViewController.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-16.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "ReDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "ReDetailModel.h"
#import "UMSocial.h"
@interface ReDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *webHolder;
@property (weak, nonatomic) IBOutlet UIImageView *pubImage;
@property (weak, nonatomic) IBOutlet UILabel *pubName;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation ReDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_pre_hl@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_share@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = YES;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.webHolder.bounds];
    ReDetailModel *model = self.model.site_info;
    [self.pubImage setImageWithURL:[NSURL URLWithString:model.pic]];
    self.pubName.text = model.name;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.model.pub_date integerValue]];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat  = @"yyyy年MM月dd日 aHH:mm:ss.S";
    NSString *dateStr = [df stringFromDate:date];
    NSString *str1 = [dateStr substringToIndex:11];
    
    self.time.text = str1;
    NSString *urlStr = self.model.origin_url;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.scalesPageToFit = YES;
    [self.webHolder addSubview:webView];

}
-(void)share{
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56a4607467e58e69c20022ba"shareText:self.model.origin_url shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToSina,UMShareToRenren,UMShareToQQ,nil] delegate:nil];
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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

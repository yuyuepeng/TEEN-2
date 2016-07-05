//
//  ALiDetaiViewController.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//
#define BASEURL @"http://218.200.160.29/rdp2/v5.5/sub/listen.do?contentid=%@&ua=Iphone_Sst&version=4.243&netType=1&toneFlag=1"
#import <MediaPlayer/MediaPlayer.h>
#include <AVFoundation/AVFoundation.h>
#import "ALiDetaiViewController.h"
#import "TListenningModel.h"
#import "LiDetaiModel.h"
#import "BLiDetailCell.h"
#import "AALiTailView.h"
#import "YYPlayer.h"
#import "RootVcManager.h"
#import "TListeningViewController.h"
#import "MusicViewController.h"
static NSString *GcellID = @"LIdetaicell";
@interface ALiDetaiViewController ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)NSIndexPath *Kindex;
@property(nonatomic,strong)AVPlayerItem *playerItem;
//@property(nonatomic,strong)LiDetaiModel *model1;
@end

@implementation ALiDetaiViewController
-(AFHTTPRequestOperationManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
}
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor lightGrayColor];
    [self createTableView];
    [self loadData];
    [self createHeadViewWithModel:self.model andModel1:self.model1];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_pre_hl@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_localMusic@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.rightBarButtonItem.tintColor = nil;
    // Do any additional setup after loading the view from its nib.
}
-(void)pop{
    [[YYPlayer sharePlayer].player pause];

}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)createHeadViewWithModel:(TListenningModel *)model andModel1:(LiDetaiModel *)model1{

    AALiTailView *view = [AALiTailView viewWithModel:model model1:model1  frame:CGRectMake(0, 0, Kwidth, 170)];
    self.tableView.tableHeaderView = view;
    

}
-(void)loadData{
    [self.manager GET:[NSString stringWithFormat:LISTENDETAIL,self.model.Fid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"wosiyizhi xiaomaolv%@",responseObject);
        self.dataSource = [TListenningModel arrayOfModelsFromDictionaries:responseObject[@"songs"]];
        self.dict = responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, Kheight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //self.tableView.estimatedRowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BLiDetailCell class]) bundle:nil] forCellReuseIdentifier:GcellID];
   
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count+2;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [self tableView:tableView cellID:@"cell"];
        cell.selectionStyle  =UITableViewCellSelectionStyleNone;

        cell.textLabel.text = self.dict[@"summary"];
        return cell;
        
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [self tableView:tableView cellID:@"cell1"];
        cell.textLabel.text = [NSString stringWithFormat:@"共%ld首",(unsigned long)self.dataSource.count];
        return cell;
    }
    BLiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:GcellID forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSelectionStyleNone;

    TListenningModel *model = self.dataSource[indexPath.row-2];
    cell.model = model;
    return cell;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellID:(NSString *)cellid{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.selectionStyle  =UITableViewCellSelectionStyleNone;
    
    //cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:9];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dianwole");
    self.Kindex = indexPath;
    
    TListenningModel *model = self.dataSource[indexPath.row-2];
//    self.playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:BASEURL,model.contentid]]];
//    [[YYPlayer sharePlayer].player replaceCurrentItemWithPlayerItem:self.playerItem];
//    [[YYPlayer sharePlayer].player play];
    

    MusicViewController *mvc = [[MusicViewController alloc]initWithNibName:@"MusicViewController" bundle:nil];
    mvc.model = model;
    mvc.currentIndex = indexPath.row - 2;
    mvc.array = self.dataSource;
    [self.navigationController pushViewController:mvc animated:YES];
   
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

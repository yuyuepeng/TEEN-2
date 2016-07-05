
//
//  FindViewController3.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-15.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//



//后两个section点击
#import "FindViewController3.h"
#import "UIImageView+AFNetworking.h"
#import "FirstCell.h"
#import "FHeadModel.h"
#import "FheadView.h"
#import "FindDetailViewController.h"
static NSString *CellID = @"first";

@interface FindViewController3 ()
{
    NSInteger _page;

}
@property (nonatomic,strong)NSMutableArray *models;

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)NSString *imageUrl;

@property(nonatomic,strong)FHeadModel *model1;


@end

@implementation FindViewController3
-(NSMutableArray *)dataSource1
{
    if (_models == nil) {
        _models = [NSMutableArray array];
        
    }
    return _models;
}

-(AFHTTPRequestOperationManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;

    [self createTableView];
    [self loadData];
    
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_pre_hl@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.title = self.model.title;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)createHeadWithModel:(FHeadModel *)model{
    FheadView *view = [FheadView viewWithModel:model];
    UITableView *tv = (id)[self.view viewWithTag:104];
    tv.tableHeaderView = view;
    
}
-(void)loadData{
    _page = 1;
    [self.manager GET:DeSection parameters:@{@"id":@([self.model.Lid integerValue]),@"page":@(_page)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.refresh finishRefreshing];
        if (_page == 1) {
            [self.models removeAllObjects];
        }
        self.models = [DetailModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"]];
        self.model1 = [[FHeadModel alloc]initWithDictionary:responseObject[@"data"][@"head"] error:nil];
        [self createHeadWithModel:self.model1];
        UITableView *tv = (id)[self.view viewWithTag:104];
        [tv reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}

-(void)createTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, Kheight - 44) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 150;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstCell class]) bundle:nil] forCellReuseIdentifier:CellID];
    tableView.tag = 104;
    self.refresh = [[DJRefresh alloc]initWithScrollView:tableView delegate:self];
    self.refresh.topEnabled = YES;
    self.refresh.bottomEnabled = YES;
    [self.view addSubview:tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",(unsigned long)self.models.count);
    
    return self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    DetailModel *model = self.models[indexPath.row];
    cell.selectionStyle  =UITableViewCellSelectionStyleNone;

    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindDetailViewController *fdvc = [[FindDetailViewController alloc]init];
    DetailModel *model = self.models[indexPath.row];
    fdvc.model = model;
    [self.navigationController pushViewController:fdvc animated:YES];

}
-(void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    if (direction ==  DJRefreshDirectionTop) {
        _page = 1;
        [self loadData];
    }
    if (direction ==  DJRefreshDirectionBottom) {
        _page ++;
        [self loadData];
    }
    
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

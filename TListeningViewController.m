//
//  TListeningViewController.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-14.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "TListeningViewController.h"
#import "TitleView.h"
#import "TListenningModel.h"
#import "LiDetaiModel.h"
#import "TListeningCell.h"
#import "ALiDetaiViewController.h"
#import "MineViewController.h"
static NSString *LcellID = @"BListenning";
typedef enum titleName{
    TuiJian = 0,
    ZuiXin,
    ZuiRe,
}TitleName;
@interface TListeningViewController ()<TitleViewDelegate>
{
    NSInteger _pageno[3];

}
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic,strong)TitleView *titleView;

@property (nonatomic,strong)NSMutableArray *dataSources;

@property (nonatomic,strong)UIScrollView *scrollView;


@end

@implementation TListeningViewController
-(AFHTTPRequestOperationManager *)manager{

    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
}
-(NSMutableArray *)dataSources{
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTitleView];
    [self createScrollView];
    [self loadDataWithType:TuiJian refresh:YES];
    [self loadDataWithType:ZuiRe refresh:YES];
    [self loadDataWithType:ZuiXin refresh:YES];
    self.navigationController.navigationBar.translucent = 0;
    // Do any additional setup after loading the view from its nib.
}


-(void)createScrollView{

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, Kwidth, Kheight - 153)];
    self.scrollView.delegate =self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(Kwidth * 3, Kheight - 64);
    
    [self createTableView];
    
    [self.view addSubview:self.scrollView];

}
-(void)createTitleView
{
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(70, 0, 180, 40)];
    titleView.titles = @[@"推荐",@"最热",@"最新"];
    titleView.layer.borderColor = (__bridge CGColorRef)([UIColor redColor]);
    
    titleView.layer.borderWidth = 5;

    titleView.delegate = self;
    self.titleView = titleView;
    [self.view addSubview:titleView];
}
-(void)loadDataWithType:(TitleName)type refresh:(BOOL)refresh{
    if (refresh) {
        _pageno[type] = 0;
    }else{
        _pageno[type]++;
    }
    NSString *str = nil;
    if (type == TuiJian) {
        str = @"http://a.vip.migu.cn/rdp2/v5.5/musicLists.do?ua=Iphone_Sst&version=4.243&sort=2&groupcode=365925&pageno=1";
    }else if (type == ZuiXin){
    str = @"http://a.vip.migu.cn/rdp2/v5.5/musicLists.do?ua=Iphone_Sst&version=4.243&sort=1&groupcode=365925&pageno=1";
    }else{
    str = @"http://a.vip.migu.cn/rdp2/v5.5/musicLists.do?ua=Iphone_Sst&version=4.243&sort=0&groupcode=365925&pageno=1";
    }

    [self.manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject[@"list"]);
        
        NSError * error = nil;
        
        [self.dataSources[type] removeAllObjects];
        
        self.dataSources[type] = [TListenningModel arrayOfModelsFromDictionaries:responseObject[@"list"] error:&error];
        [[self tableViewWithType:type] reloadData];
         //NSLog(@"CUOWU%@",error);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];

}
-(UITableView *)tableViewWithType:(TitleName)type{
    
    return (id)[self.scrollView viewWithTag:80 + type];
}

-(void)createTableView{
    for (int i = 0; i < 3; i++) {
        NSMutableArray *array = [NSMutableArray array];
        [self.dataSources addObject:array];
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(Kwidth * i, 0, Kwidth, Kheight - 153) style:UITableViewStylePlain];
        tableView.tag = 80 + i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 110;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TListeningCell class]) bundle:nil] forCellReuseIdentifier:LcellID];
        [self.scrollView addSubview:tableView];
        
    }

}
#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.dataSources[tableView.tag - 80] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TListeningCell *cell = [tableView dequeueReusableCellWithIdentifier:LcellID forIndexPath:indexPath];
    TListenningModel *model = self.dataSources[tableView.tag - 80][indexPath.row];
    cell.selectionStyle  =UITableViewCellSelectionStyleNone;
    LiDetaiModel *model1 = model.owner;
    cell.model = model;
    
    cell.model1 = model1;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ALiDetaiViewController *aldvc = [[ALiDetaiViewController alloc]init];
    TListenningModel *model = self.dataSources[tableView.tag - 80][indexPath.row];
    LiDetaiModel *model1 = model.owner;
    aldvc.model = model;
    aldvc.model1 = model1;
    [self.navigationController pushViewController:aldvc animated:YES];
}
#pragma mark - titleView
-(void)titleView:(TitleView *)view selectIndex:(NSInteger)index{

    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width, 0) animated:YES];
}
#pragma mark - scrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (self.scrollView == scrollView) {
        NSInteger index = self.scrollView.contentOffset.x/Kwidth;
        [self.titleView clickButton:self.titleView.buttons[index]];
    }

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView == scrollView) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
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

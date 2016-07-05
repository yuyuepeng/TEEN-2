//
//  TReadingViewController.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-14.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "TReadingViewController.h"
#import "allRequestable.h"
#import "TitleView.h"
#import "TreadingCell1.h"
#import "TreadingModel.h"
#import "ReDetailModel.h"
#import "MineViewController.h"
#import "ReDetailViewController.h"
static NSString *cellID = @"Areading";
typedef enum titleName{
    shiping = 0,
    wenyi,
}TitleName;

@interface TReadingViewController ()<TitleViewDelegate>
{
    NSInteger _offset[2];
}
@property (nonatomic,strong)TitleView * titleView;
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)NSMutableArray * dataSources;
@property (nonatomic,strong)AFHTTPRequestOperationManager * manager;
@property (nonatomic,strong)NSMutableArray * refreshs;//保留下拉控件
@end

@implementation TReadingViewController
-(NSMutableArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = [NSMutableArray array];
        
    }
    
    return _dataSources;
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
    
    self.tabBarController.tabBar.hidden = NO;
    
    [[self tableViewWithType:shiping] reloadData];
    
    [[self tableViewWithType:wenyi] reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = 0;
    [self createTitleView];
    [self newThread];
    [self createScrollView];
    [self startAnimationHud];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)newThread{
    NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(downloadData) object:nil];
    NSThread * thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(downloadData1) object:nil];
    
    [thread start];
    
    [thread1 start];
}
-(void)downloadData{


    [self loadDataWithType:shiping refresh:YES];
    

}
-(void)downloadData1{

    [self loadDataWithType:wenyi refresh:YES];

}
-(void)createScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, Kwidth, Kheight - 103)];
    
    self.scrollView.delegate = self;
    
    [self createTableView];
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.contentSize = CGSizeMake(Kwidth * 2, self.scrollView.frame.size.height);
    
    [self.view addSubview:self.scrollView];

}
-(void)createTableView{
    self.refreshs = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(Kwidth * i , 0 , Kwidth, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        
        NSMutableArray *models = [NSMutableArray array];
        [self.dataSources addObject:models];
               tableView.tag = 70 + i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 256;
        
        [self.scrollView addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TreadingCell1 class]) bundle:nil] forCellReuseIdentifier:cellID];
        DJRefresh *refresh = [[DJRefresh alloc]initWithScrollView:tableView delegate:self];
        
        refresh.topEnabled = YES;
        refresh.bottomEnabled = YES;
        //fresh 需被保留一次
        [self.refreshs addObject:refresh];
    }

}
-(void)createTitleView{
    TitleView * titleView = [[TitleView alloc]initWithFrame:CGRectMake(60, 0, 200, 40)];
    
    titleView.titles = @[@"时评",@"文艺"];
    
    titleView.delegate = self;
    
    self.titleView = titleView;
    
    [self.view addSubview:titleView];

}
#pragma mark - downLoad
-(void)loadDataWithType:(TitleName)type refresh:(BOOL)refresh{
    if (refresh) {
        _offset[type] = 0;
    }else{
    
        _offset[type]++;
    }
       NSString *urlStr = @"http://reader.smartisan.com/index.php?r=article/getList";
    NSMutableDictionary * dic;
    if (type == shiping) {
        
    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"site_id":@(1),@"offset":@(_offset[type]),@"page_size":@(20)}];
        
        
    }else{
        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"site_id":@(614),@"offset":@(_offset[type]),@"page_size":@(20)}];
    
    }
    [self.manager GET:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"woshitreading%@woshitreading",responseObject[@"data"][@"list"]);
        NSError * error = nil;
        
        [self.refresh finishRefreshing];
        if (_offset[type] == 1) {
            
            [self.dataSources[type] removeAllObjects];

        }
        [self stopHud];
      self.dataSources[type] = [TreadingModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"] error:&error];
        
       // NSLog(@"%@",error);
        
        [[self tableViewWithType:type] reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
-(UITableView *)tableViewWithType:(TitleName)type{

    return (id)[self.scrollView viewWithTag:70 + type];
}
#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataSources[tableView.tag - 70] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TreadingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSelectionStyleNone;

    TreadingModel *model = self.dataSources[tableView.tag - 70][indexPath.row];
    ReDetailModel *model1 = model.site_info;
    cell.model = model;
    cell.model1 = model1;
//    for (UIView *view in cell.subviews) {
//        [view removeFromSuperview];
//    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TreadingModel *model = self.dataSources[tableView.tag - 70][indexPath.row];
    ReDetailViewController *rdVC = [[ReDetailViewController alloc]init];
    
    rdVC.model = model;
    [self.navigationController pushViewController:rdVC animated:YES];


}
#pragma mark - titleView delegate
-(void)titleView:(TitleView *)view selectIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width, 0) animated:YES];
    
    if ([self.dataSources[index] count]) {
        [self loadDataWithType:(TitleName)index refresh:YES];
    }

}
#pragma mark- scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollView == scrollView) {
        NSInteger index = self.scrollView.contentOffset.x/Kwidth;
        [self.titleView clickButton:self.titleView.buttons[index]];
    }

}
-(void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    TitleName type = (TitleName)(refresh.scrollView.tag - 70);
    if (direction == DJRefreshDirectionTop) {
        //顶部
        [self loadDataWithType:type refresh:YES];
        
    }else{
        //底部 下一页
        [self loadDataWithType:type refresh:NO];
        
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

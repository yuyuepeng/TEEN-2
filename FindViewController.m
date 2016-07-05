//
//  FindViewController.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-8.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//
#import "MYHeadViewController.h"
#import "FindViewController4.h"
#import "FindViewController.h"
#import "FindViewController1.h"
#import "FirstCell.h"
#import "TitleView.h"
#import "DetailModel.h"
#import "SecondCell.h"
#import "HeadModel.h"
#import "FindViewController3.h"
#import "FindViewController2.h"
#import "FindDetailViewController.h"
#import "MineViewController.h"
#define TableViewTag 10
typedef enum titleType{
    FaXian = 0,
    FenLei,

}TitleType;
static NSString *KfirstCell = @"first";
static NSString *KsecondCell = @"second";

@interface FindViewController ()<TitleViewDelegate>

{
    NSInteger _page[2];

}

@property(nonatomic,strong)TitleView *titleView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *dataSources;

@property(nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property(nonatomic,assign) NSInteger sectionNumber;

@property(nonatomic,strong)FindModel *model;

@end

@implementation FindViewController

-(AFHTTPRequestOperationManager *)manager
{
    if (_manager == nil) {
        _manager = [[AFHTTPRequestOperationManager alloc]init];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json",nil];
    }
    return _manager;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createHead];

    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTitles];
    [self createScrollView];
    [self loadDataWithType:FaXian refresh:YES];
    [self loadDataWithType:FenLei refresh:YES];
    [self createHead];
   

//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    self.navigationController.navigationBar.translucent = 0;
    // Do any additional setup after loading the view from its nib.
}
//-(void)push{
//    MineViewController *mvc = [[MineViewController alloc]init];
//    [self.navigationController pushViewController:mvc animated:YES];
//}
-(void)createHead{
    
[self.manager GET:[NSString stringWithFormat:BaseUrl,Scroll] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSMutableArray *array = [HeadModel arrayOfModelsFromDictionaries:responseObject[@"data"]];
   
    [self updateHeadViewWithModels:array];
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    NSLog(@"%@",error);
    
}];
    
}

-(void)updateHeadViewWithModels:(NSArray *)models{

    HeadView *view = [HeadView viewWithModels:models frame:CGRectMake(0, 0, Kwidth, 150)];
    
    view.delegate = self;
    [self tableViewWithType:FaXian].tableHeaderView = view;

}
-(void)createTitles
{
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(60, 0, 200, 40)];
    titleView.titles = @[@"发现",@"分类"];
    titleView.delegate = self;
    self.titleView = titleView;

    //titleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleView];
}
-(void)createScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, Kwidth, Kheight -103)];
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.delegate = self;
    
    [self createTableView];
    self.scrollView.contentSize = CGSizeMake(Kwidth * 2, Kheight - 104);
    [self.view addSubview:self.scrollView];
    
}

-(void)createTableView
{
    self.dataSources = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        NSMutableArray *models = [NSMutableArray array];
        
        [self.dataSources addObject:models];
        UITableView *tableView;
        if (i == 0) {
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, Kheight - 120) style:UITableViewStyleGrouped];
        }
        if (i == 1) {
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(Kwidth, 0, Kwidth, Kheight - 155) style:UITableViewStylePlain];
        }
      
        tableView.tag = TableViewTag + i;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstCell class]) bundle:nil] forCellReuseIdentifier:KfirstCell];
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SecondCell class]) bundle:nil] forCellReuseIdentifier:KsecondCell];
        [self.scrollView addSubview:tableView];
    }
    
}

#pragma mark - 分类解析
-(void)loadDataWithType:(TitleType)type refresh:(BOOL)refresh{
    if (refresh) {
        _page[type] = 0;
    }else  {
    
        _page[type]++;
    }
    NSString *urlStr = nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page[type])}];
    if (type == FaXian) {
    urlStr = [NSString stringWithFormat:BaseUrl,Find];
        [self.manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self.dataSources[type] removeAllObjects];
            [self.dataSources[type] addObjectsFromArray:[FindModel arrayOfModelsFromDictionaries:responseObject[@"data"]]];

            //NSLog(@"shuju%@",responseObject[@"data"]);
            [[self tableViewWithType:type] reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    if (type == FenLei){
    
        urlStr = [NSString stringWithFormat:BaseUrl,Sort];
        [self.manager GET:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self.dataSources[type] removeAllObjects];
            [self.dataSources[type] addObjectsFromArray:[FindModel arrayOfModelsFromDictionaries:responseObject[@"data"]]];
           // NSLog(@"shuju1%@",responseObject[@"data"]);
            
            [[self tableViewWithType:type] reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
}
-(UITableView *)tableViewWithType:(TitleType)type
{

    return (id)[self.scrollView viewWithTag:type + TableViewTag];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableView代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 10) {
        if (indexPath.section == (self.sectionNumber - 2)) {
            return Kwidth;
        }
        return 150;
    }
    if (tableView.tag == 11) {
        return Kwidth;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (tableView.tag - TableViewTag) {
        case 0:
        {
        self.sectionNumber = [self.dataSources[tableView.tag - TableViewTag] count];
        return [self.dataSources[tableView.tag - TableViewTag] count];
            }
            break;
        case 1:{
            return [self.dataSources[tableView.tag - TableViewTag] count];
        }
        default:
            return 0;
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 10) {
        FindModel *model = self.dataSources[tableView.tag - TableViewTag][section];
        return model.sub.count;
    }
    if (tableView.tag == 11) {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 11) {
    SecondCell *cell3 = [tableView dequeueReusableCellWithIdentifier:KsecondCell forIndexPath:indexPath];
    FindModel *model2 = self.dataSources[tableView.tag - TableViewTag][indexPath.section];
    cell3.model1 = model2;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.opaque = YES;

    return cell3;
}
    if (tableView.tag == 10) {
        tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
            if (indexPath.section < (self.sectionNumber - 2)) {
        FirstCell *cell1 = [tableView dequeueReusableCellWithIdentifier:KfirstCell forIndexPath:indexPath];
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        FindModel *model = self.dataSources[tableView.tag - TableViewTag][indexPath.section];
                
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        DetailModel *model1 = (DetailModel *)model.sub[indexPath.row];
            
        cell1.model = model1;
                cell1.opaque = YES;
        return cell1;
    }
    if ((indexPath.section >=(self.sectionNumber - 2))&&(indexPath.section <= (self.sectionNumber - 1))) {
        
        SecondCell *cell2 = [tableView dequeueReusableCellWithIdentifier:KsecondCell forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        FindModel *model = self.dataSources[tableView.tag - TableViewTag][indexPath.section];
        
        DetailModel *model1 = model.sub[indexPath.row ];//将字典强转成model;
        
        cell2.model = model1;
        cell2.opaque = YES;
        return cell2;
    }
    }
 
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 10) {
        return 25;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;

}
//选择对应行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindDetailViewController *fdvc = [[FindDetailViewController alloc]init];
    FindModel *model1 = self.dataSources[tableView.tag - TableViewTag][indexPath.section];
    DetailModel *model2 = model1.sub[indexPath.row];
    fdvc.model = model2;
    if (tableView.tag == 10) {
        if (indexPath.section < (self.sectionNumber - 2)) {
            //前两组
            [self.navigationController pushViewController:fdvc animated:YES];
        }
        if ((indexPath.section >=(self.sectionNumber - 2))&&(indexPath.section <= (self.sectionNumber - 1))) {
        //后两组
            FindViewController3 *fvc3 = [[FindViewController3 alloc]init];
            fvc3.model = model2;
            [self.navigationController pushViewController:fvc3 animated:YES];
        }
    }
    if (tableView.tag == 11) {
       // 第二个tableView 分类
        FindModel *model = self.dataSources[tableView.tag - TableViewTag][indexPath.row];
        FindViewController4 *fvc4 = [[FindViewController4 alloc]init];
        fvc4.model = model;
        [self.navigationController pushViewController:fvc4 animated:YES];
    }
    
    

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 10) {
        if (section < self.sectionNumber - 2) {
            UIView *view = [self createViewWithSetcion:section tableView:tableView];
    FindModel *model1 = self.dataSources[tableView.tag - TableViewTag][section];
            self.model = model1;
        UIButton *button = [[UIButton alloc]initWithFrame:view.bounds];
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(Kwidth - 30, 2, 21, 19)];
        [button1 setBackgroundImage:[UIImage imageNamed:@"activities_next_hl@2x"] forState:UIControlStateNormal];
        [button addSubview:button1];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    return view;
}
        if ((section >=(self.sectionNumber - 2))&&(section <= (self.sectionNumber - 1))) {

         
         UIView *view = [self createViewWithSetcion:section tableView:tableView];
            return view;
        }
        
}
    return nil;
}
-(UIView *)createViewWithSetcion:(NSInteger)section tableView:(UITableView *)tableView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, 25)];
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 5, 25)];
    greenView.layer.cornerRadius = 2.5;
    greenView.layer.masksToBounds = YES;
    greenView.backgroundColor = [UIColor colorWithRed:88/255.0 green:189/255.0 blue:36/255.0 alpha:1.0];
    [view addSubview:greenView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, Kwidth - 40, 25)];
    label.font = [UIFont systemFontOfSize:17];
    FindModel *model = self.dataSources[tableView.tag - TableViewTag][section];
    label.text = model.title;
    [view addSubview:label];
    return view;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return nil;
}
#pragma mark-titleView代理方法
-(void)titleView:(TitleView *)view selectIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width, 0) animated:YES];
    
    if ([self.dataSources[index] count]) {
        [self loadDataWithType:(TitleType)index refresh:YES];
    }
    
    
}
#pragma mark - scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollView == scrollView) {
        
        //点击头视图button时 scrollView 的偏移量
        NSInteger index = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
        
        [self.titleView clickButton:self.titleView.buttons[index]];
    }
}
-(void)onClick:(UIButton *)button
{
//section的点击事件
   
    FindViewController1 *fvc1 = [[FindViewController1 alloc]init];
    fvc1.model1 = self.model;
    [self.navigationController pushViewController:fvc1 animated:YES];
}
#pragma mark - HeadView代理
-(void)pushToNextViewControllerWithModel:(HeadModel *)model{
//    
   MYHeadViewController *hvc = [[MYHeadViewController alloc]init];
    FindViewController2 *fvc2 = [[FindViewController2 alloc]init];
    fvc2.model = model;
    hvc.model = model;
    if (![model.url  isEqual: @""]) {
        [self.navigationController pushViewController:hvc animated:YES];
    }else{
        [self.navigationController pushViewController:fvc2 animated:YES];
    }
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

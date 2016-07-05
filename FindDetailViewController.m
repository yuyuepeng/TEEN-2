//
//  FindDetailViewController.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-14.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "FindDetailViewController.h"
#import "LeaderDetailModel.h"
#import "DetailCell.h"
#import "LeaderDetailView.h"
#import "TitleView.h"
#import "UIImageView+AFNetworking.h"
#import "FindModel.h"
#import "CommentCell.h"
#import "CommentCell1.h"
#import "UMSocial.h"
static NSString *BcellID = @"comment1";
static NSString *DcellID = @"comment2";

typedef enum titleName{
    Gaiyao = 0,
    Info,
    Price,
    Conment,
    
}TitleName;

static NSString * CellID = @"Kdetail";
@interface FindDetailViewController ()<UIScrollViewDelegate,TitleViewDelegate>


{
    NSString *_title;

}
@property (weak, nonatomic) IBOutlet UIScrollView *BottomScroll;
@property (weak, nonatomic) IBOutlet UIView *leaderView;

@property (weak, nonatomic) IBOutlet UIView *nextView;
@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSMutableArray *models;
@property(nonatomic,strong)TitleView *titleView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSArray *dataSources;
@property(nonatomic,strong)LeaderDetailModel *model1;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FindDetailViewController
-(AFHTTPRequestOperationManager *)manager{
    
    
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json",nil];
    }
    return _manager;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHeadData];
    [self createTitles];
    [self createScrollView];
    [self createTableView];
    [self loadData];
    self.dataSources = @[@[@"目的地",@"简介",@"联系方式"],@[@"内容",@"要求",@"收获",@"时间"],@[@"价格",@"包括",@"不包括"]];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_pre_hl@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_share@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    
    self.title = @"项目详情";
    
    // Do any additional setup after loading the view from its nib.
}
-(void)share{
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56a4607467e58e69c20022ba" shareText:self.model.shareUrl shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToSina,UMShareToRenren,UMShareToQQ,nil] delegate:nil];
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)loadHeadData{
    [self.manager GET:InfoHead parameters:@{@"infoId":@([self.model.infoId integerValue])} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject[@"data"][@"pics"]);
        self.models = responseObject[@"data"][@"pics"];
        _title  = responseObject[@"data"][@"title"];
        
        [self createHeadViewWithArray:self.models string:_title];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"qqqqqqqqqqq%@",error);
    }];
   
}
-(void)createHeadViewWithArray:(NSMutableArray *)models string:(NSString *)title{
    LeaderDetailView *view = [LeaderDetailView viewWithArray:models frame:CGRectMake(0, 0, Kwidth, 140) string:_title];
    [self.leaderView addSubview:view];
}
-(void)createScrollView;
{
    //self.BottomScroll.contentSize = CGSizeMake(Kwidth, Kheight + self.leaderView.frame.size.height);
    self.BottomScroll.contentSize = CGSizeMake(Kwidth, Kheight*2);
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, Kwidth, self.nextView.frame.size.height - 80)];//高为父视图 的高减去titleView的高;
   
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate =self;
    [self createTitles];
    self.scrollView.contentSize = CGSizeMake(Kwidth * 4, self.scrollView.frame.size.height);
    self.nextView.userInteractionEnabled = YES;
    [self.nextView addSubview:self.scrollView];
    

}

-(void)createTableView{
    for (int i = 0; i<4; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(Kwidth * i, 0, Kwidth, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.userInteractionEnabled = YES;
        tableView.tag = 60 + i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 135;
        
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailCell class]) bundle:nil] forCellReuseIdentifier:CellID];
        if (tableView.tag == 63) {
            [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:BcellID];
            [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell1 class]) bundle:nil] forCellReuseIdentifier:DcellID];
        }
        self.scrollView.userInteractionEnabled = YES;
        
        [self.scrollView addSubview:tableView];
    }



}
-(void)loadData{
    
    [self.manager GET:InfoHead parameters:@{@"infoId":@([self.model.infoId integerValue])} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
        self.model1 = [[LeaderDetailModel alloc]initWithDictionary:responseObject[@"data"] error:nil];
        NSString *destination = [NSString stringWithFormat:@"%@·%@",self.model1.countryCn,self.model1.cityCn];
        NSString *connection = [NSString stringWithFormat:@"电话:%@\n\n邮箱%@\n\n%@",self.model1.phone,self.model1.email,self.model1.contactLoc];
        self.array = @[@[destination,self.model1.intro,connection],@[self.model1.projectContent,self.model1.projectDemand,self.model1.projectGet,self.model1.projectTimeDesc],@[self.model1.price,self.model1.priceWith,self.model1.priceWithout]];
        [[self tableViewWithType:Gaiyao] reloadData];
          [[self tableViewWithType:Info] reloadData];
          [[self tableViewWithType:Price] reloadData];
          [[self tableViewWithType:Conment] reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"qqqqqqqqqqq%@",error);
    }];
    [self.manager GET:DeCommmet parameters:@{@"sid":@([self.model.infoId integerValue])} success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"jjjjjjjj%@jjjjj",responseObject);
        self.dataArray = [FindModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"list"]];
        [[self tableViewWithType:Conment] reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // NSLog(@"jjjjjjjj%@jjjjj",error);

    }];
//page=1&sid=11841
}
-(UITableView *)tableViewWithType:(TitleName)type
{
    return (id)[self.scrollView viewWithTag:type+60];
}
-(void)createTitles
{
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0,Kwidth, 40)];
    titleView.titles = @[@"概要",@"详情",@"费用",@"评论"];
    titleView.delegate = self;
    self.titleView = titleView;
    
    //titleView.backgroundColor = [UIColor redColor];
    [self.nextView addSubview:titleView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 60) {
        return 3;
    }if (tableView.tag == 61) {
        return 4;
    }if (tableView.tag == 62) {
        return 3;
    }if (tableView.tag == 63) {
        return self.dataArray.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 60) {
       // cell.model = self.model1;
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.selectionStyle  =UITableViewCellSelectionStyleNone;

        cell.title.text = self.dataSources[0][indexPath.row];
        cell.info.text = self.array[0][indexPath.row];
        return cell;
        
    }if (tableView.tag == 61) {
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
//        cell.model1 = self.model1;
        cell.selectionStyle  =UITableViewCellSelectionStyleNone;

        cell.title.text = self.dataSources[1][indexPath.row];
        cell.info.text = self.array[1][indexPath.row];

        return cell;
    }if (tableView.tag == 62) {
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        //cell.model2 = self.model1;
        cell.selectionStyle  =UITableViewCellSelectionStyleNone;

        cell.title.text = self.dataSources[2][indexPath.row];
        cell.info.text = self.array[2][indexPath.row];

        return cell;
    
    }if (tableView.tag == 63) {
        
        FindModel *model = self.dataArray [indexPath.row];
        NSArray *array = model.replys;
        
        if (array.count) {
            DetailModel *model1 = array[0];
            CommentCell1 *cell = [tableView dequeueReusableCellWithIdentifier:DcellID forIndexPath:indexPath];
            cell.model = model;
            cell.selectionStyle  =UITableViewCellSelectionStyleNone;

            cell.model1  =model1;
            return cell;
        }else{
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:BcellID forIndexPath:indexPath];
            cell.selectionStyle  =UITableViewCellSelectionStyleNone;

            cell.model = model;
            return cell;
        }
    
    }
    return nil;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 63) {
        FindModel *model = self.dataArray[indexPath.row];
        NSArray *array = model.replys;
        if (array.count) {
            DetailModel *model1 = array[0];
            //自定义cell 的高度
            CGRect rect = [model.username boundingRectWithSize:CGSizeMake(Kwidth-165, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
            CGRect rect1 = [model.content boundingRectWithSize:CGSizeMake(Kwidth - 80, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
            CGRect rect2 = [model1.content boundingRectWithSize:CGSizeMake(Kwidth - 85, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
           
            float height = rect.size.height + rect1.size.height +rect2.size.height + 70;
            if (height < 120) {
                height = 120;
            }
            return height;
        }else{
            CGRect rect = [model.username boundingRectWithSize:CGSizeMake(Kwidth-165, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
            CGRect rect1 = [model.content boundingRectWithSize:CGSizeMake(Kwidth - 75, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
            float height = rect.size.height + rect1.size.height + 35;
            
            if (height < 90) {
                height = 90;
            }
            return height;
        }
     
    }
    
   
    return tableView.rowHeight;
}
-(void)titleView:(TitleView *)view selectIndex:(NSInteger)index
{
    
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width, 0) animated:YES];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollView == scrollView) {
        NSInteger index = self.scrollView.contentOffset.x/Kwidth;
        [self.titleView clickButton:self.titleView.buttons[index]];
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

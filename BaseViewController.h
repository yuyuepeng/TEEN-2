//
//  BaseViewController.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-8.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "allRequestable.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "DJRefresh.h"
@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate>
@property(nonatomic,strong)MBProgressHUD * hud;
@property(nonatomic,strong)DJRefresh *refresh;


//开始转动
-(void)startAnimationHud;

//隐藏转动
-(void)stopHud;

@end

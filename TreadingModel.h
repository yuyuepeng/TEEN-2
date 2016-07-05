//
//  TreadingModel.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-16.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.

//

#import "BaseModel.h"
#import "ReDetailModel.h"

@interface TreadingModel : BaseModel
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *brief;
@property(nonatomic,strong)NSString *origin_url;
@property(nonatomic,strong)NSString *is_recommend;
@property (nonatomic,strong)NSString *prepic1;
@property (nonatomic,strong)NSString *prepic2;
@property (nonatomic,strong)NSString *prepic3;
@property(nonatomic,strong)ReDetailModel *site_info;
@property(nonatomic,strong)NSString *pub_date;
@end

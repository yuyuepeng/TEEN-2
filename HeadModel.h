//
//  HeadModel.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-12.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseModel.h"

@interface HeadModel : BaseModel
@property (nonatomic,strong)NSString *vid;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSString *url;
//@property (nonatomic,strong)NSString *type;
@property (nonatomic,assign)NSInteger spid;
@property (nonatomic,strong)NSString *shareUrl;
@property (nonatomic,strong)NSString <Optional,ConvertOnDemand>*title;
@end

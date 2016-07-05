//
//  FHeadModel.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-13.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseModel.h"

@interface FHeadModel : BaseModel

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*Hid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *intro;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *shareUrl;

@end

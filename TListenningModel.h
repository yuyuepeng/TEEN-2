//
//  TListenningModel.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseModel.h"
#import "LiDetaiModel.h"
@interface TListenningModel : BaseModel

@property(nonatomic,strong)LiDetaiModel <Optional,ConvertOnDemand>*owner;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*title;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*playNum;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*img;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*Fid;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*singer;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*tagNames;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*contentid;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*albumImg;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*url;

@end

//
//  ReDetailModel.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-16.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseModel.h"

@interface ReDetailModel : BaseModel
@property(nonatomic,copy)NSString <Optional,ConvertOnDemand>*name;
@property(nonatomic,copy)NSString <Optional,ConvertOnDemand>*pic;

@end

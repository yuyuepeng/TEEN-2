//
//  LiDetaiModel.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseModel.h"

@interface LiDetaiModel : BaseModel

@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*icon;

@end

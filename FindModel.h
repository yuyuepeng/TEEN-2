//
//  FindModel.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-10.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//


//分类model   cellmodel
#import "BaseModel.h"
#import "DetailModel.h"
@protocol DetailModel <NSObject>



@end


@interface FindModel : BaseModel

@property(nonatomic,strong)NSArray <Optional,ConvertOnDemand,DetailModel>*sub;//数组元素为detailmodel

@property(nonatomic,assign)NSInteger Kid;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*title;

@property(nonatomic,copy) NSString <Optional,ConvertOnDemand>* more;

@property(nonatomic,assign)NSString <Optional,ConvertOnDemand>* type;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*name;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*pic;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*createTime;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*content;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*username;

@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*avatar;

@property(nonatomic,strong)NSArray <Optional,ConvertOnDemand,DetailModel>*replys;
+(NSArray *)modelWithUrl:(NSString *)urlString json:(id)object;

@end

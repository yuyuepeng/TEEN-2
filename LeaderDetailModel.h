//
//  LeaderDetailModel.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-15.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseModel.h"

@interface LeaderDetailModel : BaseModel

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong) NSString *countryCn;
@property(nonatomic,strong) NSString *cityCn;
@property(nonatomic,strong)NSString <Optional>*contactLoc;
@property(nonatomic,strong)NSString <Optional>*intro;
@property(nonatomic,strong)NSString <Optional>*phone;
@property(nonatomic,strong)NSString <Optional>*email;
@property(nonatomic,strong)NSString <Optional>*projectContent;
@property(nonatomic,strong)NSString <Optional>*projectDemand;
@property(nonatomic,strong)NSString <Optional>*projectGet;
@property(nonatomic,strong)NSString <Optional>*projectTimeDesc;
@property(nonatomic,strong)NSString <Optional>*price;
@property(nonatomic,strong)NSString <Optional>*priceWith;
@property(nonatomic,strong)NSString <Optional>*priceWithout;
@property(nonatomic,strong)NSString <Optional>*btnText;
@end

//
//  DetailModel.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-10.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseModel.h"

@interface DetailModel : BaseModel

@property(nonatomic,strong) NSString <Optional,ConvertOnDemand>*title;
@property(nonatomic,strong) NSString <Optional,ConvertOnDemand>*pic;
@property(nonatomic,strong) NSString <Optional,ConvertOnDemand>*countryCn;
@property(nonatomic,strong) NSString <Optional,ConvertOnDemand>*cityCn;
@property (nonatomic,strong) NSString <Optional,ConvertOnDemand>*infoId;

@property (nonatomic, copy) NSString <Optional,ConvertOnDemand>* Lid;
//@property (nonatomic, copy) NSString <Optional,ConvertOnDemand>* top;
@property (nonatomic,copy) NSString <Optional,ConvertOnDemand>*banner;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*username;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*content;
@property(nonatomic,strong)NSString <Optional,ConvertOnDemand>*shareUrl;

@end

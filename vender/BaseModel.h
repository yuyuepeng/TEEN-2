//
//  BaseModel.h
//  12344556
//
//  Created by 扶摇先生 on 16-1-5.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface BaseModel : JSONModel

+(NSArray *)modelWithUrl:(NSString *)urlString json:(id)object;

@end

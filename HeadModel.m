//
//  HeadModel.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-12.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "HeadModel.h"

@implementation HeadModel
+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"vid"}];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
@end

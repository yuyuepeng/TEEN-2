//
//  FHeadModel.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-13.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "FHeadModel.h"

@implementation FHeadModel
+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Hid"}];
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}
@end

//
//  DetailModel.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-10.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Lid"}];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}
@end

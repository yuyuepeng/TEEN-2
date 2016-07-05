//
//  TListenningModel.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "TListenningModel.h"

@implementation TListenningModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Fid"}];
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}
@end

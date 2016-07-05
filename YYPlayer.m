//
//  YYPlayer.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-26.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "YYPlayer.h"

@implementation YYPlayer
+(YYPlayer *)sharePlayer{
    static YYPlayer *manager = nil;
    static dispatch_once_t onceToken;//
    dispatch_once(&onceToken,^{//这里边代码
        manager = [[YYPlayer alloc]init];
    });
    return manager;

}
-(id)init{
    if (self = [super init]) {
        self.player = [[AVPlayer alloc]init];
    }
    return self;
}

@end

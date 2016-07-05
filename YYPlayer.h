//
//  YYPlayer.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-26.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface YYPlayer : NSObject
@property(nonatomic,strong)AVPlayer *player;

+(YYPlayer *)sharePlayer;

@end

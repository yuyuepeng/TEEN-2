//
//  MusicViewController.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-23.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BaseViewController.h"
#import "TListenningModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YYPlayer.h"

@interface MusicViewController : BaseViewController
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)TListenningModel *model;
@property(nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,strong)AVPlayer *player;

-(void)play;
@end

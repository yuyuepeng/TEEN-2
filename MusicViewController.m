//
//  MusicViewController.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-23.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "MusicViewController.h"

#import "UIImageView+AFNetworking.h"
#import "UMSocial.h"
//static AVPlayer *player;
@interface MusicViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UIButton *playbutton;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation MusicViewController
-(AVPlayerItem * )ItemAtIndex:(NSInteger)index{
    
    
    
    
    //创建 播放源
    
    TListenningModel *model  =self.array[index];
    [self.albumImage setImageWithURL:[NSURL URLWithString:model.albumImg]];
    NSString *urlStr = [NSString stringWithFormat:@"http://218.200.160.29/rdp2/v5.5/sub/listen.do?contentid=%@&ua=Iphone_Sst&version=4.243&netType=1&toneFlag=1",model.contentid];
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
    
    return item;
    
}
- (IBAction)last:(id)sender {//上一首
    if (self.currentIndex == 0) {
        return;
    }
    
    
    AVPlayerItem * item =  [self ItemAtIndex:--self.currentIndex];
    //切换播放源
    [[YYPlayer sharePlayer].player replaceCurrentItemWithPlayerItem:item];
    [self play];
}
- (IBAction)touchDown:(id)sender {
    [self stop];
}
- (IBAction)playClick:(id)sender {
    
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"播放"]) {
        
        [self play];
        
    }else {
        //点击暂停
        [self stop];
        
    }
}
- (IBAction)next:(id)sender {
    if (self.currentIndex == self.array.count - 1) {
        AVPlayerItem * item =  [self ItemAtIndex:0];
        //切换播放源
        [[YYPlayer sharePlayer].player replaceCurrentItemWithPlayerItem:item];
        [self play];
    }
    AVPlayerItem * item =  [self ItemAtIndex:++self.currentIndex];
    //切换播放源
    [[YYPlayer sharePlayer].player replaceCurrentItemWithPlayerItem:item];
        [self play];
    
    
}
- (IBAction)cycle:(id)sender {
//    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"单曲循环"]) {
//        [sender setTitle:@"列表循环" forState:UIControlStateNormal];
//        if (self.slider.value == 0.999) {
//            //音乐总帧数
//            //float totalzhen  =  [YYPlayer sharePlayer].player.currentItem.duration.value;
//            //进度滑到的帧数
//            float value =  0;
//            __weak MusicViewController * weakSelf = self;
//            
//            [[YYPlayer sharePlayer].player seekToTime:CMTimeMake(value, [YYPlayer sharePlayer].player.currentItem.duration.timescale) completionHandler:^(BOOL finished) {
//                
//                [weakSelf play];//修改进度之后播放
//                
//            }];
//            
//        }
//    }
    
}
- (IBAction)valueChange:(UISlider *)sender {
    
    NSLog(@"修改进度 ，然后播放");
    
    //音乐总帧数
    float totalzhen  =  [YYPlayer sharePlayer].player.currentItem.duration.value;
    //进度滑到的帧数
    float value =  sender.value*totalzhen;
    
    //让播放器 跳到指定时间位置
    
    __weak MusicViewController * weakSelf = self;
    
    [[YYPlayer sharePlayer].player seekToTime:CMTimeMake(value, [YYPlayer sharePlayer].player.currentItem.duration.timescale) completionHandler:^(BOOL finished) {
        
        [weakSelf play];//修改进度之后播放
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageHeight.constant = self.albumImage.frame.size.width;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    AVPlayerItem *item = [self ItemAtIndex:self.currentIndex];
//    self.player = [YYPlayer sharePlayer].player;
//    self.player = [AVPlayer playerWithPlayerItem:item];
    [[YYPlayer sharePlayer].player replaceCurrentItemWithPlayerItem:item];
    [self observerProgress];
    [self play];
    if (self.currentIndex == self.array.count - 1) {
        if (self.slider.value == 0.99) {
            AVPlayerItem * item =  [self ItemAtIndex:0];
            [[YYPlayer sharePlayer].player replaceCurrentItemWithPlayerItem:item];
            [self play];
        }
    }

    NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
    //设置歌名
    
    infoDic[MPMediaItemPropertyArtist] = self.model.singer;
    infoDic[MPMediaItemPropertyTitle] = self.model.title;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(next:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = infoDic;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"activities_share@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    // Do any additional setup after loading the view from its nib.
}
-(void)share{
    
[UMSocialSnsService presentSnsIconSheetView:self appKey:@"56a4607467e58e69c20022ba"shareText:self.model.url shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.albumImg]]] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToSina,UMShareToRenren,UMShareToQQ,nil] delegate:nil];


}
- (void)observerProgress{
    
    __weak  MusicViewController * weakself  = self;
    
    //在手动内存管理下  __block 修饰变量 来避免循环引用
    
    [[YYPlayer sharePlayer].player addPeriodicTimeObserverForInterval:CMTimeMake(10, 1*10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        //这个代码块 会每1秒执行一次
        //self.player.currentTime 获取当前播放的时间
        float currentSecond =  [YYPlayer sharePlayer].player.currentTime.value*1.0/[YYPlayer sharePlayer].player.currentTime.timescale;//当前播放到第几秒
        
        //self.player.currentItem.duration 获取当前播放源的总时间
        
        float totalSecond = [YYPlayer sharePlayer].player.currentItem.duration.value*1.0/[YYPlayer sharePlayer].player.currentItem.duration.timescale;
        
        weakself.slider.value = currentSecond*1.000/totalSecond;
        
        //进度条值为1
//        if (weakself.slider.value == 1) {
//            [weakself next:nil];
//        }
        
    }];
    
    
    
}

-(void)play{
    [[YYPlayer sharePlayer].player play];
    [self.playbutton setTitle:@"暂停" forState:UIControlStateNormal];
}
-(void)stop{
    [[YYPlayer sharePlayer].player pause];
    [self.playbutton setTitle:@"播放" forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


//
//  AALiTailView.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "AALiTailView.h"
#import "allRequestable.h"
#import "UIImageView+AFNetworking.h"
//@property (weak, nonatomic) IBOutlet UIImageView *postHeader;
//@property (weak, nonatomic) IBOutlet UIImageView *usericon;
//@property (weak, nonatomic) IBOutlet UILabel *userName;
//@property (weak, nonatomic) IBOutlet UIButton *like;
//
//
//@property (weak, nonatomic) IBOutlet UIButton *play;
//
//@property (weak, nonatomic) IBOutlet UILabel *playNum;
//@property (weak, nonatomic) IBOutlet UILabel *tips;
//@property (weak, nonatomic) IBOutlet UIButton *share;
@implementation AALiTailView
+(instancetype)viewWithModel:(TListenningModel *)model model1:(LiDetaiModel *)model1 frame:(CGRect)frame{
    AALiTailView *view = [[[NSBundle mainBundle]loadNibNamed:@"AALiTailView" owner:nil options:nil] firstObject];
    [view.postHeader setImageWithURL:[NSURL URLWithString:model.img]];
    [view.usericon setImageWithURL:[NSURL URLWithString:model1.icon]];
    view.userName.text = model1.nickname;
    view.playNum.text = model.playNum;
    view.tips.text = model.tagNames;
    view.usericon.layer.cornerRadius = 12.5;
    view.usericon.layer.masksToBounds = YES;
    return view;
}

//btn_collect@2x  收藏   btn_hascollect@2x  已收藏
//btn_selected_mvplay@2x 播放 btn_share@2x  分享  
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

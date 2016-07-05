//
//  AALiTailView.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiDetaiModel.h"
#import "TListenningModel.h"
@interface AALiTailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *postHeader;
@property (weak, nonatomic) IBOutlet UIImageView *usericon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *like;


@property (weak, nonatomic) IBOutlet UIButton *play;

@property (weak, nonatomic) IBOutlet UILabel *playNum;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UIButton *share;
+(instancetype)viewWithModel:(TListenningModel *)model model1:(LiDetaiModel *)model1 frame:(CGRect)frame;
@end

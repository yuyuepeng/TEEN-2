//
//  TListeningCell.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-18.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "TListeningCell.h"
#import "UIImageView+WebCache.h"
@implementation TListeningCell
-(void)setModel:(TListenningModel *)model{
    _model = model;
    self.BigImageView.image = nil;
    [self.BigImageView sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:@"skybg.jpg"]];
    self.title.text = _model.title;
    self.playNum.text = _model.playNum;
}
-(void)setModel1:(LiDetaiModel *)model1{
    _model1 = model1;
    self.icon.image = nil;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_model1.icon]placeholderImage:[UIImage imageNamed:@"skybg.jpg"]];
    self.icon.layer.cornerRadius = 12.5;
    self.icon.layer.masksToBounds = YES;
    self.userName.text = _model1.nickname;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

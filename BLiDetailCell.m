//
//  BLiDetailCell.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "BLiDetailCell.h"

@implementation BLiDetailCell
-(void)setModel:(TListenningModel *)model{
    _model = model;
    self.title.text = _model.title;
    self.singer.text = _model.singer;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

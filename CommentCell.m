//
//  CommentCell.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-17.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+AFNetworking.h"
@implementation CommentCell
-(void)setModel:(FindModel *)model{
    _model = model;
    [self.headImage setImageWithURL:[NSURL URLWithString:_model.avatar]];
    self.userName.text = _model.username;
    self.content.text = _model.content;
    self.date.text = _model.createTime;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

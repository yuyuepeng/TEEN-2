//
//  CommentCell1.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-17.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "CommentCell1.h"
#import "UIImageView+AFNetworking.h"
@implementation CommentCell1
-(void)setModel:(FindModel *)model{
    _model = model;
    [self.headImage setImageWithURL:[NSURL URLWithString:_model.avatar]];
    self.userName.text = _model.username;
    self.content.text = _model.content;
    self.date.text = _model.createTime;
    
}
-(void)setModel1:(DetailModel *)model1{
    _model1  = model1;
    self.reply.text = [NSString stringWithFormat:@"%@:%@",_model1.username,_model1.content];

}
- (void)awakeFromNib {
    // Initialization code
    self.backImage.image = [[UIImage imageNamed:@"气泡.png"]stretchableImageWithLeftCapWidth:35 topCapHeight:35];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

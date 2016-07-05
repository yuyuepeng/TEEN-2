//
//  TreadingCell1.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-15.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "TreadingCell1.h"
#import "UIImageView+WebCache.h"
@implementation TreadingCell1
-(void)setModel:(TreadingModel *)model{
    _model = model;
    self.title.text = _model.title;
    self.content.text = _model.brief;
    if ([_model.is_recommend boolValue] == YES) {
        self.recomend.text = @"编辑推荐";
    }else{
       
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_model.pub_date integerValue]];
    NSString *str = [[NSString stringWithFormat:@"%@",date] substringToIndex:11];
    //NSLog(@"时间%ld", (long)[_model.pub_date integerValue]);
    self.time.text = str;
    if ([_model.prepic1  isEqual: @""]) {
        self.infoImage = nil;
        self.pic2 = nil;
        self.pic3 = nil;
    }
     self.infoImage.image = nil;
    [self.infoImage sd_setImageWithURL:[NSURL URLWithString:_model.prepic1]];
    self.pic2.image = nil;

    [self.pic2 sd_setImageWithURL:[NSURL URLWithString:_model.prepic2] ];
    self.pic3.image  = nil;

    [self.pic3 sd_setImageWithURL:[NSURL URLWithString:_model.prepic3]];
    
}
-(void)setModel1:(ReDetailModel *)model1{
    _model1 = model1;
    self.pubImage.image = nil;
    [self.pubImage sd_setImageWithURL:[NSURL URLWithString:_model1.pic] ];
    self.pubImage.layer.cornerRadius = 10;
    self.pubImage.layer.masksToBounds = YES;
    self.pubName.text = _model1.name;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SecondCell.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-11.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "SecondCell.h"
#import "UIImageView+AFNetworking.h"
#import "SXColorGradientView.h"
@interface SecondCell()
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UILabel *title;



@end


@implementation SecondCell

-(void)setModel:(DetailModel *)model{

    _model = model;
    [self.backimage setImageWithURL:[NSURL URLWithString:_model.banner]];
    self.title.text = _model.title;


}
-(void)setModel1:(FindModel *)model1{
    _model1 = model1;
    [self.backimage setImageWithURL:[NSURL URLWithString:_model1.pic]];
    self.title.text = _model1.name;

}
- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

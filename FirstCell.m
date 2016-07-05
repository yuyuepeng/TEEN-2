//
//  FirstCell.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-9.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "FirstCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+Wonderful.h"

@implementation FirstCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        }
    return self;
}

-(void)setModel:(DetailModel *)model
{
    _model = model;
    
    self.image.image = nil;
    [self.image setImageWithURL:[NSURL URLWithString:_model.pic]];
    self.title.text  = _model.title;
    self.destination.text = [NSString stringWithFormat:@"%@·%@",_model.cityCn,_model.countryCn];
    //self.title.backgroundColor = [UIColor beigeColor];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

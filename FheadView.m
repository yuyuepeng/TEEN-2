//
//  FheadView.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-13.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "FheadView.h"
#import "allRequestable.h"
#import "UIImageView+AFNetworking.h"
@interface FheadView()

@end

@implementation FheadView
+(instancetype)viewWithModel:(FHeadModel *)model{
    
    FheadView *view = [[[NSBundle mainBundle] loadNibNamed:@"FheadView" owner:nil options:nil] firstObject];
    CGRect rect = [model.intro boundingRectWithSize:CGSizeMake(Kwidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    float height = rect.size.height + view.Fimage.frame.size.height + 30;
    view.frame = CGRectMake(0, 0, Kwidth, height);
    
    [view.Fimage setImageWithURL:[NSURL URLWithString:model.pic]];
    view.Flabel.text = model.intro;

    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

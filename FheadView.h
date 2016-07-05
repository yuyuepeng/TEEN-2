//
//  FheadView.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-13.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHeadModel.h"
@interface FheadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *Fimage;
@property (weak, nonatomic) IBOutlet UILabel *Flabel;
+(instancetype)viewWithModel:(FHeadModel *)model;
@end

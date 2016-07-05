//
//  TreadingCell1.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-15.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreadingModel.h"
#import "ReDetailModel.h"
@interface TreadingCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pubImage;

@property (weak, nonatomic) IBOutlet UILabel *pubName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIImageView *infoImage;
@property (weak, nonatomic) IBOutlet UIImageView *pic2;
@property (weak, nonatomic) IBOutlet UILabel *recomend;
@property (weak, nonatomic) IBOutlet UIImageView *pic3;

@property(nonatomic,strong)TreadingModel *model;
@property(nonatomic,strong)ReDetailModel *model1;


@end

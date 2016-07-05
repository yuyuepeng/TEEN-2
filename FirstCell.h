//
//  FirstCell.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-9.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "FindModel.h"
@interface FirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *destination;
@property(nonatomic,strong)DetailModel *model;

@end

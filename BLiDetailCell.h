//
//  BLiDetailCell.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-19.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TListenningModel.h"
@interface BLiDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property(nonatomic,strong)TListenningModel *model;

@end

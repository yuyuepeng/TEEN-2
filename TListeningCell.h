//
//  TListeningCell.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-18.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TListenningModel.h"
#import "LiDetaiModel.h"
@interface TListeningCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BigImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *playNum;
@property(nonatomic,strong)TListenningModel *model;
@property(nonatomic,strong)LiDetaiModel *model1;
@end

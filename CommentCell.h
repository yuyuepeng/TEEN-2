//
//  CommentCell.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-17.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
#import "DetailModel.h"
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic,strong) FindModel *model;
@end

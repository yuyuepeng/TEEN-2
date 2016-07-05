//
//  HeadView.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-12.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadModel.h"
@protocol pushDelegate <NSObject>

-(void)pushToNextViewControllerWithModel:(HeadModel *)model;

@end


@interface HeadView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCon;
@property (nonatomic,strong) NSArray *models;
@property (weak) id<pushDelegate>delegate;

+(instancetype)viewWithModels:(NSArray *)array frame:(CGRect)frame;

@end

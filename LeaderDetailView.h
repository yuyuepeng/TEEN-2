//
//  LeaderDetailView.h
//  TEEN
//
//  Created by 扶摇先生 on 16-1-15.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderDetailView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *LeaderScroll;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *page;

+(instancetype)viewWithArray:(NSMutableArray *)array frame:(CGRect)frame string:(NSString *)title;
@end

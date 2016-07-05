//
//  LeaderDetailView.m
//  TEEN
//
//  Created by 扶摇先生 on 16-1-15.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "LeaderDetailView.h"
#import "allRequestable.h"
#import "UIImageView+AFNetworking.h"
@implementation LeaderDetailView
+(instancetype)viewWithArray:(NSMutableArray *)array frame:(CGRect)frame string:(NSString *)title{
    LeaderDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"LeaderDetailView" owner:nil options:nil] firstObject];
    view.frame = frame;
    int i = 0;
    for (NSString *headUrl in array) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Kwidth * i, 0, Kwidth, 140)];
        imageView.tag = 30 + i;
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView setImageWithURL:[NSURL URLWithString:headUrl]];
        view.LeaderScroll.pagingEnabled = YES;
        view.LeaderScroll.contentSize = CGSizeMake(Kwidth * array.count, 140);
        view.LeaderScroll.delegate = view;
        [view.LeaderScroll addSubview:imageView];
        i++;
    }
    view.title.text = title;
    view.LeaderScroll.delegate = view;
    view.page.text= [NSString stringWithFormat:@"1/%ld",array.count];
    return view;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.LeaderScroll = scrollView;
    NSInteger index = self.LeaderScroll.bounds.origin.x/self.LeaderScroll.frame.size.width;
    int b =self.LeaderScroll.contentSize.width/self.LeaderScroll.frame.size.width;
    self.page.text = [NSString stringWithFormat:@"%ld/%d",index+1,b];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

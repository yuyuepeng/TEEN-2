//
//  HeadView.m
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-12.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import "HeadView.h"
#import "UIButton+AFNetworking.h"
#import "allRequestable.h"
@interface HeadView()<UIScrollViewDelegate>

{
    NSTimer *timer;

}

@end

@implementation HeadView
-(void)setModels:(NSArray *)models{
    
    _models = models;
    
    int i = 0;
    
    for (HeadModel * model in self.models) {
        //遍历的适合注意数组元素是不是model,model和字典不一样;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        //NSLog(@"%@",model.pic);
        [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.pic]];
        
        button.tag = 100 + i;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:button];
        i++ ;
        
    }
    self.scroll.contentSize = CGSizeMake(self.frame.size.width * self.models.count, self.frame.size.height);
    self.scroll.pagingEnabled = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pagechanged) userInfo:nil repeats:YES];
    self.pageCon.numberOfPages = self.models.count;
    self.pageCon.currentPage = 0;
    self.scroll.delegate = self;
}


+(instancetype)viewWithModels:(NSArray *)array frame:(CGRect)frame
{
    HeadView *view = [[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:nil options:nil] firstObject];
    view.frame = frame;
    view.models = array;
    return view;
}
static int i = 0;
-(void)pagechanged{
    
    
   // self.pageCon.currentPage++;
    i++;
    self.scroll.contentOffset = CGPointMake(self.frame.size.width *i/2, 0);
    
    self.pageCon.currentPage = self.scroll.contentOffset.x/self.frame.size.width ;
    if (i == self.models.count * 2) {
        [timer setFireDate:[NSDate distantPast]];
        i= -1;
      
    }
}
- (IBAction)pageChanged:(UIPageControl *)sender {
    
    
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width * sender.currentPage,0) animated:YES];
    
    self.pageCon.currentPage = sender.currentPage;
}

-(void)onClick:(UIButton *)button
{
    HeadModel *model;
    if (_models[button.tag - 100]) {
        model = _models[button.tag - 100];

        [self.delegate pushToNextViewControllerWithModel:model];

    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    NSInteger index = scrollView.bounds.origin.x/scrollView.frame.size.width;
   
    
    self.pageCon.currentPage = index;
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [timer setFireDate:[NSDate distantFuture]];
    

}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [timer setFireDate:[NSDate distantPast]];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

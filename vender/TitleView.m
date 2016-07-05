//
//  TitleView.m
//  TitleScrollView
//
//  Created by 任前辈 on 16/1/6.
//  Copyright © 2016年 SingleProgrammers. All rights reserved.
//

#import "TitleView.h"

#define FontSize  20

@interface TitleView()

@property(nonatomic,strong)UIScrollView * scrollView;


@property(nonatomic,strong)UIView * lineView;//线

@end

@implementation TitleView


-(void)setTitles:(NSArray *)titles{
    
    _titles = titles;
    //更新视图显示的内容
    
    [self initView];
    
}

- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithRed:88/255.0 green:189/255.0 blue:36/255.0 alpha:1.0];
        [self.scrollView addSubview:_lineView];
    }
    
    return _lineView;
}

//初始化子视图
- (void)initView{
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
//    self.scrollView.contentSize = CGSizeMake(, );
    //设置 内容大小
    self.scrollView.contentSize = CGSizeMake([self totalWidth], self.frame.size.height);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
   // self.scrollView.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:88/255.0 green:189/255.0 blue:36/255.0 alpha:1.0]);
    
   // self.scrollView.layer.borderWidth = 2;
    
    [self selectIndex:0];//默认选中第一个
    
    //将scrollView添加到视图上
    [self addSubview:self.scrollView];
    
}
//算出总宽度  并且添加了button
-(float)totalWidth{
    
    float width = 2;
    
    for (NSString * title in _titles) {
        
     // CGRect rect =  [title boundingRectWithSize:CGSizeMake(320, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FontSize]} context:nil];//计算文字的宽度和高度
        
        
      //button的宽
        float buttonWidth = (self.frame.size.width - 2)/_titles.count - 2;
       
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
       // button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(width, 2, buttonWidth, self.frame.size.height - 4);
       
        button.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setTitle:title forState:UIControlStateNormal];
        
        [self.scrollView addSubview:button];
        
        width += buttonWidth + 2;
        
        //设置 button的选址状态的颜色
        [button setTitleColor:[UIColor colorWithRed:88/255.0 green:189/255.0 blue:36/255.0 alpha:1.0] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
//        [button setBackgroundColor:[UIColor redColor]];
        
        [self.buttons addObject:button];
        
    }
    
    return width;//返回总长度
}

-(NSMutableArray *)buttons{
    
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

//点击 button 告诉使用者 你点击了 第几个button
-(void)clickButton:(UIButton*)button{
    if (button == [_buttons lastObject]) {//如果点击是最后一个按钮 只不选中只执行代理方法
        
        //如果代理对象 可以响应方法
        if ([self.delegate respondsToSelector:@selector(titleView:selectIndex:)]) {
            
            [self.delegate titleView:self selectIndex:[self.buttons indexOfObject:button]];
            
        }

    }
    
    if (button.selected) {//如果已经选中 直接返回
        return;
    }
    
    for (UIButton * b in _buttons) {
        b.selected = NO;
    }
    
    button.selected = YES;
    
//    [self.scrollView setContentOffset:CGPointMake(button.frame.origin.x+button.frame.size.width/2 - self.scrollView.frame.size.width/2, 0) animated:YES];//设置scrollview的偏移量
    
    
   [UIView animateWithDuration:0.3 animations:^{
      //修改线的位置
       self.lineView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 3, button.frame.size.width, 3);
       
   }];
    
    //如果代理对象 可以响应方法
    if ([self.delegate respondsToSelector:@selector(titleView:selectIndex:)]) {
        
        [self.delegate titleView:self selectIndex:[self.buttons indexOfObject:button]];
        
    }
    
    
    
}


//选中第几个
-(void)selectIndex:(NSInteger)index{
    
    
    UIButton * button = self.buttons[index];
    
    
    for (UIButton * b in _buttons) {
        b.selected = NO;
    }
    
    button.selected = YES;
    
//    [self.scrollView setContentOffset:CGPointMake(button.frame.origin.x+button.frame.size.width/2 - self.scrollView.frame.size.width/2, 0) animated:YES];//设置scrollview的偏移量
   
    //修改线的位置
    self.lineView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 3, button.frame.size.width, 3);
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

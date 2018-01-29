//
//  YMMChooseBar.m
//  ymm
//
//  Created by 白亚策 on 15/12/26.
//  Copyright © 2015年 ymm. All rights reserved.
//

#import "YMMChooseBar.h"

@interface YMMChooseBar ()
@property (nonatomic, strong) UIButton * button1;
@property (nonatomic, strong) UIButton * button2;
@property (nonatomic, strong) UIView * bottomView;
@end

@implementation YMMChooseBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor clearColor];
    
    NSString * title1 = @"今日特卖";
    NSString * title2 = @"即将开始";
    
    if (_titleArray.count >= 2) {
        title1 = _titleArray[0];
        title2 = _titleArray[1];
    }

    
    CGFloat constX = 0.0f;
    CGFloat constY = 0.0f;
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button1 setTitle:title1 forState:UIControlStateNormal];
    _button1.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:16];
    [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button1.adaptiveIphone5Frame = CGRectMake(constX, constY, 160, 40);
    [_button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _button1.tag = 100;
    [self addSubview:_button1];
    
    constX += _button1.adaptiveIphone5Frame.size.width;
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button2 setTitle:title2 forState:UIControlStateNormal];
    _button2.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:16];
    [_button2 setTitleColor:[UIColor colorWithWhite:1 alpha:0.5f] forState:UIControlStateNormal];
    _button2.tag = 101;
    [_button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _button2.adaptiveIphone5Frame = CGRectMake(constX, constY, 160, 40);
    [self addSubview:_button2];
    
    UIView * hBottomView = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(constX, constY, 1,40)];
    hBottomView.backgroundColor = [UIColor gc_colorWithHexString:@"#b64700" alpha:0.5f];
    [self addSubview:hBottomView];
    
    constY += _button2.adaptiveIphone5Frame.size.height;
    _bottomView = [[UIView alloc] init];
    _bottomView.adaptiveIphone5Frame = CGRectMake(0, constY, 320.0f, 1.0f);
    _bottomView.backgroundColor = [UIColor gc_colorWithHexString:@"#b64700" alpha:0.5f];
    [self addSubview:_bottomView];
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    if (_titleArray.count <= 1) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_button1 setTitle:[_titleArray objectAtIndex:0] forState:UIControlStateNormal];
        [_button2 setTitle:[_titleArray objectAtIndex:1] forState:UIControlStateNormal];
    });

}

- (void)buttonClicked:(UIButton *)button
{
    [_button1 setTitleColor:[UIColor colorWithWhite:1 alpha:0.5f] forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor colorWithWhite:1 alpha:0.5f] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
    
//    CGFloat x = button.frame.origin.x;
//    CGRect rect = _bottomView.frame;

//    rect.origin.x = x;
    
//    [UIView animateWithDuration:0.4f animations:^{
//        _bottomView.frame = rect;
//    }];
    
    if (_indexChangeBlock) {
        _indexChangeBlock(button.tag - 100);
    }
    
}

@end

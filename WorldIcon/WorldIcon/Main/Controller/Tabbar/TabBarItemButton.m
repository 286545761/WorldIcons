//
//  RXTabBarItemButton.m
//  Toon
//
//  Created by dgs on 13-12-16.
//  Copyright (c) 2013年 dgsmac rights reserved.
//

/**
 *  自定义TabbarButtonItem
 *
 */
#import "TabBarItemButton.h"
#import "TabBarItem.h"
#import "AppDelegate.h"

#define KFONT_OF_SIZE_20PX   10
#define KTitleColor         [UIColor colorWithRed:255.0f/255.0f green:180.0f/255.0f blue:0 alpha:1.000]

@implementation TabBarItemButton

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark 根据item对象的属性初始化按钮
- (id)initWithFrame:(CGRect)frame  item:(TabBarItem *)item
{
    self = [super initWithFrame:frame];
    if (self) {
        self.item = item;
        self.adjustsImageWhenHighlighted = NO;

        self.titleLabel.font = [UIFont boldSystemFontOfSize:KFONT_OF_SIZE_20PX];//字体

        [self setTitle:item.title forState:UIControlStateNormal];//标题
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        
        [self setImage:[UIImage imageNamed:item.normalImage] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:item.highlightedImage] forState:UIControlStateSelected];//选中时高亮
    }
    return self;
}
-(NumImageView *)numView
{
    if (!_numView) {
        _numView = [[NumImageView alloc] initWithFrame:CGRectMake(45, -5, 15, 15)];
        _numView.hidden = YES;
        [self addSubview:_numView];
    }
    return _numView;
}

-(UIView *)pointView{
    if (!_pointView) {
        _pointView = [[UIView alloc]initWithFrame:CGRectMake(45, 0, 10, 10)];
        _pointView.layer.masksToBounds = YES;
        _pointView.layer.cornerRadius = _pointView.bounds.size.width/2;
        _pointView.backgroundColor = [UIColor redColor];
        _pointView.hidden = YES;
        [self addSubview:_pointView];
    }
    return _pointView;
}

-(void)setNum:(NSString *)aNum;
{
    NSInteger number = [aNum integerValue];
    if (aNum && number) {
        self.numView.hidden = NO;
        [self.numView setNum:aNum];

    }else {
        self.numView.hidden = YES;
    }
}

#pragma mark 对按钮中的标题的定制
- (CGRect)titleRectForContentRect:(CGRect)contentRect{//contentRect指的是按钮的Rect
    CGRect rect = [super titleRectForContentRect:contentRect];
    rect.origin.x = contentRect.size.width * 0.5 - rect.size.width * 0.5;//文字居中
    rect.origin.y = self.imageView.frame.size.height + 6; //文字高度:图片高度加上6
    return rect;
}

#pragma mark 对按钮中的图片的定制
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect = [super imageRectForContentRect:contentRect];
    
    //rect.size.width = 22;
    //rect.size.height = 22;
    
    rect.origin.x = contentRect.size.width * 0.5 - rect.size.width *0.5;//图片居中
    rect.origin.y = 3;//图片置顶显示
    return rect;
}

@end

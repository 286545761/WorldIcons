//
//  UIView+adaptive.m
//  ymm
//
//  Created by 白亚策 on 15/12/20.
//  Copyright © 2015年 ymm. All rights reserved.
//

#import "UIView+adaptive.h"

@implementation UIView (adaptive)

+ (CGFloat)countBeforeWithIphone5Length:(CGFloat)iphone5Length
{
    CGFloat times = kScreenWidth / 320.0f;
    CGFloat before = iphone5Length * times;
    
    return before;
}

+ (CGFloat)countIphone5LengthWithBeforeLength:(CGFloat)beforeLength
{
    CGFloat times =  320.0f / kScreenWidth;
    CGFloat before = beforeLength * times;
    
    return before;

}

+ (CGFloat)getCurrentScreenHeightAdaptiveIphone5
{
    CGFloat times =  320.0f / kScreenWidth;
    CGFloat before = kScreenHeight * times;
    
    return before;

}

- (instancetype)initWithAdaptiveIphone5Frame:(CGRect)frame
{
    self = [self init];
    self.adaptiveIphone5Frame = frame;
    return self;
}

- (void)setAdaptiveIphone5Frame:(CGRect)adaptiveadaIphone5Frame
{
    CGRect rect = [self adaptiveadaFrame:adaptiveadaIphone5Frame maxWidth:320.0f];
    self.frame = rect;
}
- (CGRect)adaptiveIphone5Frame
{
    return [self reverseTransformMaxWidth:320.0f];
}

- (CGRect)reverseTransformMaxWidth:(CGFloat)width
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CGFloat times = width / kScreenWidth;
    
    return CGRectMake(x * times, y * times, w * times, h * times);
}

- (CGRect)adaptiveadaFrame:(CGRect)frame maxWidth:(CGFloat)width
{
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;

    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;

    CGFloat times = kScreenWidth / width;
    
    return CGRectMake(x * times, y * times, w * times, h * times);
}

@end



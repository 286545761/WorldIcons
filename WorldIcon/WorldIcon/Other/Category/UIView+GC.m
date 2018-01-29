//
//  UIView+GC.m
//  Bage
//
//  Created by 陈潇 on 17/3/8.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UIView+GC.h"
#import <objc/runtime.h>

@implementation UIView (GC)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

static const char * JKR_UN_TOUCH_KEY = "JKR_UN_TOUCH";
static const char * JKR_UN_TOUCH_RECT_KEY = "JKR_UN_TOUCH_RECT";

- (UIViewController *)jkr_viewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:)), class_getInstanceMethod([UIView class], @selector(jkr_pointInside:withEvent:)));
}

- (void)setUnTouch:(BOOL)unTouch {
    objc_setAssociatedObject(self, JKR_UN_TOUCH_KEY, [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)unTouch {
    return objc_getAssociatedObject(self, JKR_UN_TOUCH_KEY) ? [objc_getAssociatedObject(self, JKR_UN_TOUCH_KEY) boolValue] : NO;
}

- (void)setUnTouchRect:(CGRect)unTouchRect {
    objc_setAssociatedObject(self, JKR_UN_TOUCH_RECT_KEY, [NSValue valueWithCGRect:unTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)unTouchRect {
    return objc_getAssociatedObject(self, JKR_UN_TOUCH_RECT_KEY) ? [objc_getAssociatedObject(self, JKR_UN_TOUCH_RECT_KEY) CGRectValue] : CGRectZero;
}

- (BOOL)jkr_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.unTouch) return NO;
    if (self.unTouchRect.origin.x == 0 && self.unTouchRect.origin.y == 0 && self.unTouchRect.size.width == 0 && self.unTouchRect.size.height == 0) {
        return [self jkr_pointInside:point withEvent:event];
    } else {
        if (CGRectContainsPoint(self.unTouchRect, point)) return NO;
        else return [self jkr_pointInside:point withEvent:event];
    }
}

@end

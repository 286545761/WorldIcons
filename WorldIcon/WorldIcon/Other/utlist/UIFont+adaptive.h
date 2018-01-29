//
//  UIFont+adaptive.h
//  ymm
//
//  Created by 白亚策 on 15/12/27.
//  Copyright © 2015年 ymm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (adaptive)
// 通过iPhone5的文字大小获取适配以后的 UIFont*
+ (UIFont *)fontWithAdaptiveIphone5Size:(CGFloat)fontSize;
@end

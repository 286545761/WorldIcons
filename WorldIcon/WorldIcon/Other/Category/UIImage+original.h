//
//  UIImage+original.h
//  TheBull
//
//  Created by 韩铭文 on 17/3/20.
//  Copyright © 2017年 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (original)
/**
 *  图片不要渲染
 *
 *  @param name 图片名字
 *
 *  @return 返回一张不要渲染的图片
 */
+ (UIImage *)imageWithRenderOriginalName:(NSString *)name;
+ (UIImage*)gc_createImageWithColor:(UIColor*)color;
@end

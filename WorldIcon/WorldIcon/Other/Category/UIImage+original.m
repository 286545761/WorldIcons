//
//  UIImage+original.m
//  TheBull
//
//  Created by 韩铭文 on 17/3/20.
//  Copyright © 2017年 HMW. All rights reserved.
//

#import "UIImage+original.h"

@implementation UIImage (original)
+ (UIImage *)imageWithRenderOriginalName:(NSString *)name{
    UIImage *image =  [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
+ (UIImage*)gc_createImageWithColor:(UIColor*)color{
    
    CGRect rect =CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    
    return theImage;
    
}

@end

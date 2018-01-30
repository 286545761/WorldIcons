//
//  UIImageView+imageView.h
//  TheBull
//
//  Created by 韩铭文 on 17/3/20.
//  Copyright © 2017年 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (imageView)
/**
 * 原图渲染后的图片
 * imageName  imageName
 */
+(UIImageView*)imageViewWithImageName:(NSString*)imageName;

/**
 * 裁剪圆角的图片
 * imageName  imageName
 * CRadius    图片裁剪的角度值
 * lineColor  图片的边框颜色
 * lineWith   图片的边框宽
 */

+(UIImageView*)imageViewWithImageName:(NSString*)imageName withCornerRadius:(CGFloat)CRadius withBorderColor:(UIColor*)lineColor withBorderWidth:(CGFloat)lineWith;


/**
 *  四周拉伸  的图片
 * imageName  imageName
 */
+(UIImageView*)TheTensileImageViewWithImageName:(NSString*)imageName;

@end

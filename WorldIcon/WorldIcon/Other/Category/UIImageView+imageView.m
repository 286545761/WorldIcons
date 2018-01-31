

//
//  UIImageView+imageView.m
//  TheBull
//
//  Created by 韩铭文 on 17/3/20.
//  Copyright © 2017年 HMW. All rights reserved.
//

#import "UIImageView+imageView.h"

@implementation UIImageView (imageView)
+(UIImageView*)imageViewWithImageName:(NSString*)imageName{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageWithRenderOriginalName:imageName];
    return imageView;
}

+(UIImageView*)imageViewWithImageName:(NSString*)imageName withCornerRadius:(CGFloat)CRadius withBorderColor:(UIColor*)lineColor withBorderWidth:(CGFloat)lineWith{
    UIImageView *imageView=[self imageViewWithImageName:imageName];
    imageView.layer.cornerRadius=CRadius;
    imageView.layer.borderColor=lineColor.CGColor;
    imageView.layer.borderWidth=lineWith;
    imageView.layer.masksToBounds=YES;
    return imageView;
}
+(UIImageView*)TheTensileImageViewWithImageName:(NSString*)imageName{
    UIImageView *imageView=[[UIImageView alloc]init];
    UIImage *image=[UIImage imageNamed:imageName];
    // 设置上左下右边距
    CGFloat topMode= image.size.height * 0.1;
    CGFloat leftMode= image.size.width * 0.1;
    CGFloat bottomMode= image.size.height * 0.1;
    CGFloat rightMode= image.size.width * 0.5;
    
    UIEdgeInsets edgeInsetsMode= UIEdgeInsetsMake(topMode, leftMode, bottomMode, rightMode);
    
    // 拉伸图片
    UIImage *edgeModeImage = [image resizableImageWithCapInsets:edgeInsetsMode resizingMode:UIImageResizingModeStretch];
    //    UIImage *edgeModeImage = [image resizableImageWithCapInsets:edgeInsetsMode resizingMode:UIImageResizingModeTile];
    
    //设置图片

 

    imageView.image=edgeModeImage;

    
    return imageView;
}
@end

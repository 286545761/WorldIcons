//
//  tool.h
//  洋妈妈
//
//  Created by 郭飞燕 on 16/6/23.
//  Copyright © 2016年 ymm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tool : NSObject

#pragma mark - 设置不同字体颜色(lable)
+(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range;
#pragma mark - 设置不同字体颜色(button)
+(void)fuwenbenButton:(UIButton *)labell FontNumber:(id)font AndRange:(NSRange)range;


+(void)fuwenbenLable:(UILabel *)labell AndRange:(NSRange)range;


#pragma mark - 文字自适应宽度
+(CGSize)characterAdaption:(NSString *)Str
                  withFont:(UIFont *)font;

#pragma mark - 文字自适应高度
+(CGRect)characterAdaptionHeight:(NSString *)Str
                        withSize:(CGSize )size
                        withFont:(UIFont *)font;

#pragma mark - 行间距设置
+(NSAttributedString *)setLineHeight:(NSString *)str
                          withHeight:(NSInteger )height
                           withRange:(NSRange )range;

#pragma mark - 时间计算
+(NSString *)gc_getDateFromATimeStamp:(NSNumber *)timeStamp;

#pragma mark - 字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;

//上传图片
//+(void)uploadUserPhotoApiWithPargams:(NSDictionary *)pargams withName:(NSString *)name withFileName:(NSString *)filename withmimeType:(NSString *)mimeType withData:(NSData *)data completion:(void (^)(NSDictionary *model, NSError *error))completion;

#pragma mark - 去掉空格
+ (NSString *)removeSpaceAndNewline:(NSString *)aString;

#pragma mark -- 获取fileID
+(NSDictionary *)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages;

#pragma mark - 图片自适应宽度
+(CGFloat )setImageURLSize:(NSString*)imageURL
                 withImage:(UIImageView *)imageView
                   withStr:(NSString *)str;

#pragma mark - 图片自适应宽度
+(CGFloat )setImageImage:(UIImageView *)imageView;



+ (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines text:(NSString *)text;

#pragma mark - 对图片尺寸进行压缩--
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

#pragma mark - 图片裁剪
+(UIImage*)image:(NSString*)imageURL  fortargetSize: (CGSize)targetSize;

+ (UIViewController *)getCurrentVC;

+(CGSize)getSizeWithString:(NSString *)string andFont:(UIFont*)font andMaxSize:(CGSize)maxSize;
#pragma mark - 时间戳转时间 精确到天
+(NSString * )dayStringFromDateStrng:(id)timeString;
#pragma mark - 时间戳转时间 精确到秒
+(NSString * )secondStringFromDateStrng:(id)timeString;

#pragma mark - 时间转时间戳 精确到秒
+(NSString *)secondDateStrngFromString;

#pragma mark - 判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

#pragma mark - 转码
+ (NSString *)URLEncodedString;

#pragma mark - 保存图片到相册
+ (void)loadImageFinished:(UIImage *)image;

#pragma mark - 检查银行卡号
+(BOOL)checkCardNo:(NSString*) cardNo;
@end

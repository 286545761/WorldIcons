//
//  NSString+GC.h
//  Bage
//
//  Created by 陈潇 on 17/3/9.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GC)
//时间戳转换时间格式
+(NSString *)gc_getDateFromATimeStamp:(NSNumber *)timeStamp;
//获取IP
+(NSString *)gc_getIPAddress:(BOOL)preferIPv4;
+(NSString *)transToDate:(NSString *)timsp;
#pragma mark --- MD5加密
+(NSString *)md5:(NSString *)input;
#pragma mark -- 格式化金额
+(NSString *)priceFormatterWithPrice:(CGFloat)price;
//计算文字的高度
-(CGFloat)heightWithWidth:(CGFloat)width font:(CGFloat)font;
//时间戳距离当前时间
+(NSString *)updateTimeForRow:(NSTimeInterval)timeInterval;
#pragma mark -- 判断输入是否是数字
+ (BOOL)gc_judgeNumInputShouldNumber:(NSString *)str;
/**
 判断手机号格式是否正确
 
 @param phoneNumber 手机号码
 
 @return 正确返回YES 否则NO
 */
+(BOOL)gc_judgePhoneNumber:(NSString *)phoneNumber;

+(NSString*)stringFromDate:(NSDate*)date;

+(NSDate*)dateFromString:(NSString*)string;

@end

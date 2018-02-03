//
//  tool.m
//  洋妈妈
//
//  Created by 郭飞燕 on 16/6/23.
//  Copyright © 2016年 ymm. All rights reserved.
//

#import "tool.h"

#define HOST_URL       @"http://hb.lchtime.com"
#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
NSString * const uploadUserPhoto_url                    = @"/index.php/system/upload/";
@implementation tool

//设置不同字体颜色
+(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range
{
    if (labell.text.length != 0) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
        //设置字号
        [str addAttribute:NSFontAttributeName value:font range:range];
        labell.attributedText = str;
    }
}

#pragma mark - 设置不同字体颜色
+(void)fuwenbenButton:(UIButton *)labell FontNumber:(id)font AndRange:(NSRange)range 
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.currentTitle];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    [labell setAttributedTitle:str forState:UIControlStateNormal];
}

+(void)fuwenbenLable:(UILabel *)labell AndRange:(NSRange)range
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    [str addAttribute:NSForegroundColorAttributeName
                value:RGBA(231, 60, 95, 1)
                range:range];
    labell.attributedText = str;
}


#pragma mark - 文字自适应宽度
+(CGSize)characterAdaption:(NSString *)Str
                  withFont:(UIFont *)font
{
    return [Str sizeWithAttributes:@{NSFontAttributeName:font}];
}

#pragma mark - 文字自适应高度
+(CGRect)characterAdaptionHeight:(NSString *)Str
                        withSize:(CGSize )size
                        withFont:(UIFont *)font
{
    return [Str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
}

#pragma mark - 行间距设置
+(NSAttributedString *)setLineHeight:(NSString *)str
                          withHeight:(NSInteger )height
                           withRange:(NSRange )range
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:height];//行距的大小
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

#pragma mark - 时间戳转时间
+(NSString *)gc_getDateFromATimeStamp:(NSNumber *)timeStamp{
    
    long time = [timeStamp longValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *date = [NSDate date];
    NSTimeInterval form = [confromTimesp timeIntervalSince1970]*1;
    NSTimeInterval current = [date timeIntervalSince1970]*1;
    NSTimeInterval value = current - form;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *str = [formatter1 stringFromDate:confromTimesp];
    NSString *currentstr = [formatter1 stringFromDate:date];
//    NSLog(@"%@",str);
    if (![[str substringWithRange:NSMakeRange(0, 4)]isEqualToString:[currentstr substringWithRange:NSMakeRange(0, 4)]]) {
        return  [formatter1 stringFromDate:confromTimesp];
    }
    else if (![[str substringWithRange:NSMakeRange(5, 2)]isEqualToString:[currentstr substringWithRange:NSMakeRange(5, 2)]])
    {
        return [str substringWithRange:NSMakeRange(5,str.length-5)];
    }
    else if (![[str substringWithRange:NSMakeRange(8, 2)]isEqualToString:[currentstr substringWithRange:NSMakeRange(8, 2)]])
    {
        if ([[currentstr substringWithRange:NSMakeRange(8, 2)]integerValue]-[[str substringWithRange:NSMakeRange(8, 2)] integerValue]==2) {
            return [NSString stringWithFormat:@"前天%@",[str substringWithRange:NSMakeRange(10,str.length-10)] ];
        }
        if ([[currentstr substringWithRange:NSMakeRange(8, 2)]integerValue]-[[str substringWithRange:NSMakeRange(8, 2)] integerValue]==1) {
            return [NSString stringWithFormat:@"昨天%@",[str substringWithRange:NSMakeRange(10,str.length-10)] ];
        }
        if ([[currentstr substringWithRange:NSMakeRange(8, 2)]integerValue]-[[str substringWithRange:NSMakeRange(8, 2)] integerValue]>2) {
            return [str substringWithRange:NSMakeRange(5,str.length-5)];
        }
    }
    else
        if (house == 0) {
            NSLog(@"%d",second);
            if (minute > 1) {
                return [NSString stringWithFormat:@"%d分钟",minute];
            }
            else
                return @"刚刚";
        }
        else
            return [NSString stringWithFormat:@"%d小时前",house];
    return nil;
}


// 字典转json字符串方法

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
        NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}






#pragma mark - 去除字符串中的空格和换行符
+ (NSString *)removeSpaceAndNewline:(NSString *)aString {
    if ([[aString class] isSubclassOfClass:[NSString class]]) {
        NSString *temp = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        return temp;
    }
    return nil;
}

+(CGFloat )setImageURLSize:(NSString*)imageURL
                 withImage:(UIImageView *)imageView
                   withStr:(NSString *)str
{
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: imageURL];
    
    // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了，除了高度不固定的文字部分。
    if (!image) {
        image = [UIImage imageNamed:@"Wechat"];
        //  图片不存在，下载图片
        [self downloadImage:imageURL withStr:str];
    }
    else
    {
        imageView.image = image;
        //手动计算cell
        //自适应图片,让图片完整的显示出来
        CGFloat w1 =imageView.image.size.width;
        CGFloat h1 = imageView.image.size.height;
        CGFloat bili = w1/h1;
        return bili;
    }
    return 0;
}

#pragma mark - 图片自适应宽度
+(CGFloat )setImageImage:(UIImageView *)imageView{
    //手动计算cell
    //自适应图片,让图片完整的显示出来
    CGFloat w1 =imageView.image.size.width;
    CGFloat h1 = imageView.image.size.height;
    CGFloat bili = w1/h1;
    return bili;
}

/**
 *  计算最大行数文字高度,可以处理计算带行间距的
 */
+ (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines text:(NSString *)text{
    
    if (maxLines <= 0) {
        return 0;
    }
    CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
    
    CGSize orginalSize = [self boundingRectWithSize:size font:font lineSpacing:lineSpacing text:text];
    
    if ( orginalSize.height >= maxHeight ) {
        return maxHeight;
    }else{
        return orginalSize.height;
    }
}

/**
 * 计算文字高度，可以处理计算带行间距的
 */
+ (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing text:(NSString *)text
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    
    //    NSLog(@"size:%@", NSStringFromCGSize(rect.size));
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:text]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    return rect.size;
}



//判断如果包含中文
+ (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){ int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}


+(UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
   // [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (void)downloadImage:(NSString*)imageURL
              withStr:(NSString *)str
{
    // 利用 SDWebImage 框架提供的功能下载图片
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:(SDWebImageDownloaderUseNSURLCache) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL toDisk:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程做操做
            // 请求完成 刷新代码
            [[NSNotificationCenter defaultCenter] postNotificationName:str object:nil];
        });
    }];
}

//对图片尺寸进行压缩--

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    NSArray * views = [window subviews];
    if (views.count) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
        return result;
    }
    return nil;
}


+(CGSize)getSizeWithString:(NSString *)string andFont:(UIFont*)font andMaxSize:(CGSize)maxSize;{
    //设置一个行高上限
    CGSize size = maxSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    size = rect.size;
#else
    size = [string sizeWithFont:font constrainedToSize:size];
#endif
    return size;
}
//时间戳转时间 精确到天
+(NSString * )dayStringFromDateStrng:(id)timeString;
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * string = [dateFormatter stringFromDate:date];
    
    return string;
}
//时间戳转时间 精确到秒
+(NSString * )secondStringFromDateStrng:(id)timeString;
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * string = [dateFormatter stringFromDate:date];
    
    return string;
}

//时间转时间戳 精确到秒
+(NSString *)secondDateStrngFromString{
    NSDate * senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSDate * now = [dateformatter dateFromString:locationString];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[now timeIntervalSince1970]];
    return timeSp;
}

#pragma mark - 判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11){
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
    return encodedString;
}

+ (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

#pragma mark - 检查银行卡号
+(BOOL)checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1]intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

#pragma mark - 检出字符串中的数字
+(CGFloat)findNumFromStr:(NSString *)originalString
{
    // Intermediate
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    // Result.
    CGFloat number = [numberString floatValue];
    return number;
}


@end

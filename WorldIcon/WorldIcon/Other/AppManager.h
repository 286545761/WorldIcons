//
//  AppManager.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/14.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

#pragma mark -- 根据url访问图片
+(NSString *)getPhotoUrlFileID:(NSString *)fileid;
#pragma mark -- 判断设备
+(NSString *)iphoneType;
@end


//
//  AppDefine.h
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//
//  PS: App 项目用到的参数定义 -> URL 的入参、通知名字、SDK 的 AppKey 等

#ifndef AppDefine_h
#define AppDefine_h

#ifdef __OBJC__
    #import <Foundation/Foundation.h> //下面要是用到 Foundation 库就要包括
#endif

#define Hosturl @"http://vmvm.lchtime.cn:8001";

#define kDefaultImg              @""

//用户
#define USERID              @"UD_UserId"
#define USEROC              @"UD_UserOC"
#define USERPHONE           @"UD_UserPhone"
#define USERNAME            @"UD_UserName"


#endif /* AppDefine_h */

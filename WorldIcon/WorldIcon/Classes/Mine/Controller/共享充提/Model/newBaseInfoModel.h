//
//  newBaseInfoModel.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface newBaseInfoModel : JSONModel
/**
 *类型
 */
@property(nonatomic,copy)NSString *typeString;
/**
 *账号文本
 */
@property(nonatomic,copy)NSString *acountTextString;
/**
 *账号
 */
@property(nonatomic,copy)NSString *acountString;
/**
 *姓名
 */
@property(nonatomic,copy)NSString *acoutNameString;
/**
 *<##>
 */
@property(nonatomic,copy)NSString *acountName;
/**
 *<##>
 */
@property(nonatomic,copy)NSString *localTextString;
/**
 *<##>
 */
@property(nonatomic,copy)NSString <Optional>*local;
/**
 *<##>
 */
@property(nonatomic,copy)NSString <Optional>*addString;
@property(nonatomic,copy)NSString <Optional>*marginString;

@end

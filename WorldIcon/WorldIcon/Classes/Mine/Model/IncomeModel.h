//
//  IncomeModel.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/28.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface IncomeModel : JSONModel
///收益来源用户昵称
@property (nonatomic,copy)NSString<Optional> *vi_from_ub_nn;
///收益数量
@property (nonatomic,copy)NSString<Optional> *vi_income;
///层次
@property (nonatomic,copy)NSString<Optional> *vi_level;
///单位
@property (nonatomic,copy)NSString<Optional> *vi_unit;
@end

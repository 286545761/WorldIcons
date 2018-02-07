//
//  KLineItem.h
//  ChartDemo
//
//  Created by xdliu on 2016/12/2.
//  Copyright © 2016年 taiya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KLineItem : JSONModel

// 开盘价
@property (nonatomic, copy) NSString<Optional> *open;

// 收盘价
@property (nonatomic, copy) NSString<Optional> *close;

// 最高价
@property (nonatomic, copy) NSString<Optional> *high;

// 最低价
@property (nonatomic, copy) NSString<Optional> *low;

// 日期
@property (nonatomic, copy) NSString<Optional> *date;

// 成交量 
@property (nonatomic, copy) NSString<Optional> *vol;

@end

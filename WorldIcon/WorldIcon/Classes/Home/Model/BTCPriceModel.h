//
//  BTCPriceModel.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BTCPriceModel : JSONModel

@property (nonatomic,copy)NSString<Optional> *ve_id;
@property (nonatomic,copy)NSString<Optional> *ve_jyfe;
@property (nonatomic,copy)NSString<Optional> *ve_jyl;
@property (nonatomic,copy)NSString<Optional> *ve_name;
@property (nonatomic,copy)NSString<Optional> *ve_name_ch;
@property (nonatomic,copy)NSString<Optional> *ve_price_btc;
@property (nonatomic,copy)NSString<Optional> *ve_price_usd;
@property (nonatomic,copy)NSString<Optional> *ve_sz;
@property (nonatomic,copy)NSString<Optional> *ve_zdf_day;
@property (nonatomic,copy)NSString<Optional> *ve_zdf_week;

@end

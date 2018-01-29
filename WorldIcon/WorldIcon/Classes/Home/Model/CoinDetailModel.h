//
//  CoinDetailModel.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CoinDetailModel : JSONModel
@property (nonatomic,copy)NSString<Optional> *vf_dongjie;
@property (nonatomic,copy)NSString<Optional> *vf_ub_id;
@property (nonatomic,copy)NSString<Optional> *vf_jk;
@property (nonatomic,copy)NSString<Optional> *vf_tk;
@property (nonatomic,copy)NSString<Optional> *vf_yk;
@property (nonatomic,copy)NSString<Optional> *vf_coin;
@property (nonatomic,copy)NSString<Optional> *sell;
@property (nonatomic,copy)NSString<Optional> *buy;

@end

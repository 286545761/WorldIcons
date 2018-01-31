//
//  PriceModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BuyModel,SellModel,BuySellModel,ListModel;

@interface PriceModel : JSONModel
/*
 "amount": "0.00", 
 "mount": "0.00", 
 "coin": 0, 
 "kycoin": 0
 */
@property (nonatomic,copy)NSArray<Optional,BuyModel> *buy;
@property (nonatomic,copy)NSArray<Optional,SellModel> *sell;
@property (nonatomic,copy)NSArray<Optional,BuySellModel> *BuySell;

@property (nonatomic,strong)NSString<Optional> *amount;
@property (nonatomic,strong)NSString<Optional> *mount;
@property (nonatomic,strong)NSString<Optional> *coin;
@property (nonatomic,strong)NSString<Optional> *kycoin;

@end

@interface BuyModel : JSONModel
/*
 "vb_b": "1.02",
 "num": "5998"
 */
@property (nonatomic,strong)NSString<Optional> *vb_b;
@property (nonatomic,strong)NSString<Optional> *num;

@end

@interface SellModel : JSONModel
/*
 "vs_s": "2.50",
 "num": "1598"
 */
@property (nonatomic,strong)NSString<Optional> *vs_s;
@property (nonatomic,strong)NSString<Optional> *num;

@end

@interface BuySellModel : JSONModel
/*
 "vb_id": 123,
 "vb_ub_id": 506, 
 "vb_code": "000001", 
 "vb_b": "2.00",
 "vb_bc": 55,
 "vb_date": "2017-10-25",
 "vb_time": "15:21:19", 
 "vb_status": 1, 
 "vb_count": 0,
 "vb_fee": "0.00",
 "vb_info": "\u7b49\u5f85\u4ea4\u6613", 
 "vb_date1": "2017-10-25",
 "vb_time1": "15:21:19",
 "datetime": "2017-10-25 15:21:19", 
 "type": 1
 */
@property (nonatomic,strong)NSString<Optional> *vb_id;
@property (nonatomic,strong)NSString<Optional> *vb_ub_id;
@property (nonatomic,strong)NSString<Optional> *vb_code;
@property (nonatomic,strong)NSString<Optional> *vb_b;
@property (nonatomic,strong)NSString<Optional> *vb_bc;
@property (nonatomic,strong)NSString<Optional> *vb_date;
@property (nonatomic,strong)NSString<Optional> *vb_time;
@property (nonatomic,strong)NSString<Optional> *vb_status;
@property (nonatomic,strong)NSString<Optional> *vb_count;
@property (nonatomic,strong)NSString<Optional> *vb_fee;
@property (nonatomic,strong)NSString<Optional> *vb_info;
@property (nonatomic,strong)NSString<Optional> *vb_date1;
@property (nonatomic,strong)NSString<Optional> *vb_time1;
@property (nonatomic,strong)NSString<Optional> *datetime;
@property (nonatomic,strong)NSString<Optional> *type;

@end

@interface HistoryListModel : JSONModel

@property (nonatomic,strong)NSArray<Optional,ListModel> *list;
@property (nonatomic,strong)NSString<Optional> *vsb_date;

@end

@interface ListModel : JSONModel
/*
 "vsb_id": 181, 
 "vsb_ub_id": 506, 
 "vsb_code": "000001",
 "vsb_sb": "2.00", 
 "vsb_sbc": 2,
 "vsb_type": 0,
 "vsb_date": "2017-10-25",
 "vsb_status": 3,   

 "vsb_count": 2,
 "vsb_fee": "4.00",
 "vsb_info": "\u5168\u90e8\u4ea4\u6613", 
 "vsb_time": "15:07:32",
 "vsb_date1": null,
 "vsb_time1": null
 */
@property (nonatomic,strong)NSString<Optional> *vsb_id;
@property (nonatomic,strong)NSString<Optional> *vsb_ub_id;
@property (nonatomic,strong)NSString<Optional> *vsb_code;
@property (nonatomic,strong)NSString<Optional> *vsb_sb;
@property (nonatomic,strong)NSString<Optional> *vsb_sbc;
@property (nonatomic,strong)NSString<Optional> *vsb_type;
@property (nonatomic,strong)NSString<Optional> *vsb_date;
@property (nonatomic,strong)NSString<Optional> *vsb_status;
@property (nonatomic,strong)NSString<Optional> *vsb_count;
@property (nonatomic,strong)NSString<Optional> *vsb_fee;
@property (nonatomic,strong)NSString<Optional> *vsb_info;
@property (nonatomic,strong)NSString<Optional> *vsb_time;
@property (nonatomic,strong)NSString<Optional> *vsb_date1;
@property (nonatomic,strong)NSString<Optional> *vsb_time1;

@end

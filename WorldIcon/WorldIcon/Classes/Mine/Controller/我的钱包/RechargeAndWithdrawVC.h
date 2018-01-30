//
//  RechargeAndWithdrawVC.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "WIBaseViewController.h"
@class ShareStateModel;
typedef NS_ENUM(NSInteger, OLBRechargeWithdrawType) {
    OLBRechargeType,                    //美元充值
    OLBWithdrawType                     //美元提现
};
@interface RechargeAndWithdrawVC : WIBaseViewController
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *vra_id;
/// 0-充值 1-提现
@property (nonatomic,assign)OLBRechargeWithdrawType type;
@property (nonatomic,strong)ShareStateModel *model;
@end

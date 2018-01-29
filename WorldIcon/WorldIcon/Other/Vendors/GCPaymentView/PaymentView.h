//
//  PaymentView.h
//  bage
//
//  Created by 陈潇 on 17/4/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTPasswordView.h"


@interface PaymentView : UIView

@property (nonatomic, copy) void(^didClickCell)(NSIndexPath *ind);

@property (nonatomic,strong)UITableView *mainTableView;

@property (nonatomic,strong)TTPasswordView *password;

@property (nonatomic,strong)UILabel *redbag_InfoLabel;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *redbag_moneyLabel1;
//0 余额  1 微信 2 支付宝
@property (nonatomic,assign)NSInteger payType;
//@property (nonatomic,strong)PasswordView *psView;

@end

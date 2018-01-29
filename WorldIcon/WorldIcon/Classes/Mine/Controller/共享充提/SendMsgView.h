//
//  SendMsgView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"
#import "OSAddressPickerView.h"

typedef void(^SENDBLOCK)();

@interface SendMsgView : UIView

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic;

@property (nonatomic,copy)SENDBLOCK block;

@property (nonatomic,strong)InputView *username;
@property (nonatomic,strong)InputView *khhAddress;
@property (nonatomic,strong)InputView *cardNumber;
@property (nonatomic,strong)InputView *userAddress;
@property (nonatomic,strong)OSAddressPickerView *addressPickerView;
@property (nonatomic,strong)UIButton *sendBtn;
/*
 _province = province;
 _city = city;
 _district = district;
 */
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *district;

@end

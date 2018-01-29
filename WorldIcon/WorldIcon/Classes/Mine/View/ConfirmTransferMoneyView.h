//
//  ConfirmTransferMoneyView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/11/2.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface ConfirmTransferMoneyView : UIView
@property (nonatomic,strong)InputView *hkjeLabel;
@property (nonatomic,strong)InputView *hktimeLabel;

@property (nonatomic,copy)void(^submitBlock) ();

@end

//
//  CurrentIconNumberView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoinDetailModel;
@interface CurrentIconNumberView : UIView
-(instancetype)initWithFrame:(CGRect)frame withDic:(CoinDetailModel *)model;
@end

//
//  BaseInfoView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ACTIONBLOCK)(NSInteger tag);

@interface BaseInfoView : UIView

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic;

@property (nonatomic,copy)ACTIONBLOCK block;

@end

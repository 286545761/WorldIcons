//
//  BaozhjinView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface BaozhjinView : UIView

@property (nonatomic,strong)InputView *hkmbLabel;
@property (nonatomic,strong)InputView *hkLabel;
@property (nonatomic,strong)InputView *hkjeLabel;
@property (nonatomic,strong)InputView *hktimeLabel;

@property (nonatomic,copy)void(^timeBlock)();
@property (nonatomic,copy)void(^mbzhBlock)();
@property (nonatomic,copy)void(^sumlimtBlock)();
@property (nonatomic,copy)void(^tapBlock)();
@property (nonatomic,copy)void(^zhBlock)();

@end

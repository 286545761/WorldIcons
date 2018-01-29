//
//  DealView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DealView;

@protocol DealViewDelagate <NSObject>

-(void)closeDealView:(DealView *)dealView;

-(void)cancleDealView:(DealView *)dealView;

-(void)didClickButtonWithTag:(NSInteger)tag;
@end

typedef void(^PRICEJIABLOCK)();
typedef void(^PRICEJIANBLOCK)();
typedef void(^ACCOUNTJIABLOCK)();
typedef void(^ACCOUNTJIANBLOCK)();
typedef void(^DIDCDEALBUTTON)();

@interface DealView : UIView

@property (nonatomic,copy)PRICEJIABLOCK pricejiablock;
@property (nonatomic,copy)PRICEJIANBLOCK pricejianblock;
@property (nonatomic,copy)ACCOUNTJIABLOCK accountjiablock;
@property (nonatomic,copy)ACCOUNTJIANBLOCK accountjianblock;
@property (nonatomic,copy)DIDCDEALBUTTON didClickButtonBlock;

@property (nonatomic,strong)UITextField *priceField;
@property (nonatomic,strong)UITextField *countField;

@property (nonatomic,assign)id<DealViewDelagate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withDealType:(NSString *)dealType withNumber:(NSString *)number withField1:(NSString *)text1 withField2:(NSString *)text2;

@end

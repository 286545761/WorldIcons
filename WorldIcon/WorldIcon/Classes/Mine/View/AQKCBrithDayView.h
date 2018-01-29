//
//  AQKCBrithDayView.h
//  safeCar
//
//  Created by 郭飞燕 on 17/4/18.
//  Copyright © 2017年 郭飞燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AQKCDayChooseViewDelegate <NSObject>

- (void)ensureBtnOnClick:(NSString *)type;

- (void)cancelBtnOnClick;
@end
@interface AQKCBrithDayView : UIView

@property (nonatomic, weak) id<AQKCDayChooseViewDelegate> delegate;
@property(nonatomic,strong)UIView *backView;
@end

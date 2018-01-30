//
//  ShareCTView.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareCTViewBtnChooseViewDelegate <NSObject>
- (void)bottomPassBtnOnClick;
@end

@interface ShareCTView : UIView
@property (nonatomic, weak) id<ShareCTViewBtnChooseViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame;
@end

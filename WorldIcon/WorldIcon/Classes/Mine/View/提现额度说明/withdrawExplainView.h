//
//  withdrawExplainView.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BtnChooseViewDelegate <NSObject>
- (void)bottomPassBtnOnClick;
@end

@interface withdrawExplainView : UIView
@property (nonatomic, weak) id<BtnChooseViewDelegate> delegate;
@end

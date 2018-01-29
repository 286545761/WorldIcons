//
//  inviteFriendView.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class inviteFriendModel;
@protocol inviteBtnChooseViewDelegate <NSObject>
- (void)bottomPassBtnOnClick;
@end

@interface inviteFriendView : UIView
@property (nonatomic, weak) id<inviteBtnChooseViewDelegate> delegate;

- (instancetype)initWithModel:(inviteFriendModel *)model;
@end

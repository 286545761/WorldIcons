//
//  NumImageView.h
//  RongXin
//
//  Created by wdart on 13-12-18.
//  Copyright (c) 2013年 KSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumImageView : UIImageView

@property (nonatomic,strong)  UILabel *numLabel;
@property (nonatomic)  CGFloat viewSizeWith;

// 未读消息数显示修改
-(void)setNum:(NSString *)aNum;

@end

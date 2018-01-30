//
//  ShowTwoCell.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowTwoContentDelegate <NSObject>
- (void)ShowTwoTextChanged:(NSString *)content;
@end

@interface ShowTwoCell : UITableViewCell
@property (nonatomic) id<ShowTwoContentDelegate> delegate;
@property (assign, nonatomic) NSInteger maxNum;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,strong)UIView *topV;
@property (nonatomic,strong)UIView *bottomV;
-(void)reloadView:(NSArray *)arr;
+(CGFloat)getCellHeight;
@end

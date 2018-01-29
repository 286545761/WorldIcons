//
//  CardCell.h
//  bage
//
//  Created by 郭飞燕 on 2017/12/5.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CardContentDelegate <NSObject>
- (void)textChanged:(NSString *)content1 Text:(NSString *)content2
              other:(NSString *)content3;
@end
@interface CardCell : UITableViewCell
@property (nonatomic) id<CardContentDelegate> delegate;
@property (nonatomic , copy) void(^provinceBtnBlock)(NSString *text);
@property (nonatomic , copy) void(^accountBtnBlock)(NSString *text);
@property (assign, nonatomic) NSInteger maxNum;
@property (nonatomic,copy) NSString *inputOldStr;
-(void)reloadCell:(NSArray *)arr
           isshow:(BOOL)show;
@end

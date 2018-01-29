//
//  AlipayCell.h
//  bage
//
//  Created by 郭飞燕 on 2017/12/6.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlipayContentDelegate <NSObject>
- (void)textChanged:(NSString *)content1 andText:(NSString *)content2 tag:(NSString *)str;
@end
@interface AlipayCell : UITableViewCell
@property (nonatomic) id<AlipayContentDelegate> delegate;
@property (assign, nonatomic) NSInteger maxNum;
@property (nonatomic,copy) NSString *inputOldStr;
-(void)reloadView:(NSArray *)arr;
@end

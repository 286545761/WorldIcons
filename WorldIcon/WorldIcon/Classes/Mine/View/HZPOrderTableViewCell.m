//
//  HZPOrderTableViewCell.m
//  洋妈妈
//
//  Created by 郭飞燕 on 17/3/31.
//  Copyright © 2017年 ymm. All rights reserved.
//

#import "HZPOrderTableViewCell.h"
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=8.0 ? YES : NO)
@interface HZPOrderTableViewCell()
@property(nonatomic,strong)UILabel *lookAllOrder;
@end
@implementation HZPOrderTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
//        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initview];
    }
    return self;
}

-(void)initview
{
    _myOrderLable = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 12, 140,20)];
    _myOrderLable.text = @"我的订单";
    _myOrderLable.font = [UIFont fontWithAdaptiveIphone5Size:15];
    _myOrderLable.textAlignment = NSTextAlignmentLeft;
    _myOrderLable.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    [self.contentView addSubview:_myOrderLable];
    
    _lookAllOrder = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(320-20-150, 13, 150, 18)];
    _lookAllOrder.textAlignment = NSTextAlignmentRight;
    _lookAllOrder.text = @"查看全部订单";
    _lookAllOrder.numberOfLines = 0;
    _lookAllOrder.font = [UIFont fontWithAdaptiveIphone5Size:14];
    _lookAllOrder.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    [self.contentView addSubview:_lookAllOrder];
    
//    if ([UIApplication sharedApplication].isRegisteredForRemoteNotifications==NO) {
//        if ([[HZPUserInfo sharedInstance].isOpenPush isEqualToString:@"0"]) {
//            _pushSwitch.on = NO;//设置初始为ON的一边
//        }
//    }else{
//        if ([[HZPUserInfo sharedInstance].isOpenPush isEqualToString:@"0"]) {
//            _pushSwitch.on = NO;//设置初始为的NO一边
//        }else
//            _pushSwitch.on = YES;//设置初始为Yes的一边
//    }
}


-(void)reloadViewTitleLable:(NSString *)titleStr
              WithShowLable:(NSString *)showstr
{
    _myOrderLable.text = titleStr;
    _lookAllOrder.text = showstr;
}

-(void)reloadViewWithTitleLable1:(NSString *)titleStr
                 withRightLable:(NSArray *)array{
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

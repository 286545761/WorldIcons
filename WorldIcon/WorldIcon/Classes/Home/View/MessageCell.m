//
//  MessageCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/20.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()

@property (nonatomic,strong)UILabel *messageType;
@property (nonatomic,strong)UILabel *messageContent;
@property (nonatomic,strong)UILabel *messageDate;
@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UIView *back;
@end

@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    _back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 10, 300, [UIView countIphone5LengthWithBeforeLength:75])];
    _back.backgroundColor = [UIColor whiteColor];
    _back.layer.masksToBounds = YES;
    _back.layer.cornerRadius = 8;
    [self.contentView addSubview:_back];
    
    //消息类别
    UILabel *messageType = [UILabel gc_labelWithTitle:@"系统消息" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [_back addSubview:messageType];
    self.messageType = messageType;
    //消息内容
    UILabel *messageContent = [UILabel gc_labelWithTitle:@"龙创时代智能穿戴式、应用式穿戴技术" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    messageContent.numberOfLines = 0;
    messageContent.adjustsFontSizeToFitWidth = NO;
    [_back addSubview:messageContent];
    self.messageContent = messageContent;
    //消息时间
    UILabel *messageDate = [UILabel gc_labelWithTitle:@"15:30" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:13 withTextAlignment:(NSTextAlignmentRight)];;
    [_back addSubview:messageDate];
    self.messageDate = messageDate;
}

-(void)setModel:(MessageModel *)model{

    if (model.vm_info_title) {
        self.messageType.text = [NSString stringWithFormat:@"%@",model.vm_info_title];
    }
    if (model.vm_date) {
        self.messageDate.text = [NSString stringWithFormat:@"%@",model.vm_date];
    }
    if (model.vm_info_content) {
        self.messageContent.text = [NSString stringWithFormat:@"%@",model.vm_info_content];
    }
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.messageType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.right.equalTo(self.back).offset(-10);
        make.height.mas_equalTo(kRatioY6(20));
        make.top.mas_equalTo(self.back).offset(7.5);
    }];
    
    [self.messageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.right.equalTo(self.back).offset(-10);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.messageType.mas_bottom).offset(0);
    }];
    
    [self.messageDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.back).offset(-10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
        make.centerY.mas_equalTo(self.messageType.mas_centerY);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(0);
        make.right.equalTo(self.back).offset(0);
        make.bottom.mas_equalTo(self.back.mas_bottom);
        make.height.equalTo(@10);
    }];
    
    [super updateConstraints];
    
}
/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}


@end

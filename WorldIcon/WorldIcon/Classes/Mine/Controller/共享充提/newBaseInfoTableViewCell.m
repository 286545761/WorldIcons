//
//  newBaseInfoTableViewCell.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newBaseInfoTableViewCell.h"


@interface newBaseInfoTableViewCell()
/**
 * 银行卡 名字  和选项
 */
@property(nonatomic,strong)UIView *bandNameTextView;
/**
 *<##>
 */
@property(nonatomic,strong)UILabel *bandNameTextLable;
/**
 *<##>
 */
@property(nonatomic,strong)UIButton *editorInfoButton;

/**
 *账号
 */
@property(nonatomic,strong)UILabel *acountLabel;


/**
 *姓名
 */
@property(nonatomic,strong)UILabel *acountNameLabel;
/**
 *账号
 */
@property(nonatomic,strong)UILabel *localLabel;

@end


@implementation newBaseInfoTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

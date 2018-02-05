//
//  newCurrentProgressInfoMessageAViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressInfoMessageAViewController.h"


@interface newCurrentProgressInfoMessageAViewController()
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *fromeLabel;
@property(nonatomic,strong)UILabel *contentLabel;



@end
@implementation newCurrentProgressInfoMessageAViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        @property(nonatomic,strong)UILabel *timeLabel;
//        @property(nonatomic,strong)UILabel *fromeLabel;
//        @property(nonatomic,strong)UILabel *contentLabel;
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.fromeLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    
    return self;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =[UILabel gc_labelWithTitle:@"111111" withTextColor:[UIColor whiteColor] withTextFont:12 withTextAlignment:NSTextAlignmentCenter];
        _timeLabel.backgroundColor =RGBA(189, 189, 189, 1);
    }
    return _timeLabel;
    
}
-(UILabel *)fromeLabel{
    if (!_fromeLabel) {
        _fromeLabel =[UILabel gc_labelWithTitle:@"ceshi1" withTextColor:[UIColor gc_colorWithHexString:@"#66666"] withTextFont:13 withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _fromeLabel;
}
-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        _contentLabel =[UILabel gc_labelWithTitle:@"dede" withTextColor:[UIColor whiteColor] withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
        _contentLabel.backgroundColor =RGBA(159, 192, 191, 1);
    }
    return _contentLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.equalTo(@13);
        make.width.equalTo(@200);
    }];
    [self.fromeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
        
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.fromeLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
        
    }];
}

@end

//
//  newCurrentProgressInfoMessageUITableViewCell.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressInfoMessageUITableViewCell.h"
#import "sendMessageModel.h"

@interface newCurrentProgressInfoMessageUITableViewCell()
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *fromeNameLabel;
@property(nonatomic,strong)UILabel *contentLabel;




@end
@implementation newCurrentProgressInfoMessageUITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(sendMessageModel *)model{
    _model =model;
   self.fromeNameLabel.text=@"deqda";
    self.timeLabel.text=model.vc_date;
    self.contentLabel.text=model.vc_context;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.fromeNameLabel];
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
-(UILabel *)fromeNameLabel{
    if (!_fromeNameLabel) {
        _fromeNameLabel =[UILabel gc_labelWithTitle:@"ceshi1" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:13 withTextAlignment:NSTextAlignmentLeft];

        
    }
    return _fromeNameLabel;
}
-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        _contentLabel =[UILabel gc_labelWithTitle:@"dede" withTextColor:[UIColor whiteColor] withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
        _contentLabel.backgroundColor =RGBA(159, 192, 191, 1);
        _contentLabel.numberOfLines=0;
//        _contentLabel.backgroundColor=[UIColor clearColor];
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
//    self.fromeNameLabel.backgroundColor =[UIColor yellowColor];
    [self.fromeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
        
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.fromeNameLabel.mas_bottom).offset(10);
        make.height.equalTo(@40);
        
    }];
}

@end

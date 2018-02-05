//
//  newCurrentProgressSharersTableViewCell.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
// 共享者

#import "newCurrentProgressSharersTableViewCell.h"


@interface newCurrentProgressSharersTableViewCell ()

@property(nonatomic,strong) UILabel *nameLabel;

@property(nonatomic,strong) UILabel *numberLabel;
@property(nonatomic,strong) UILabel *whereItIsLabel;

@property(nonatomic,strong) UILabel *RMBLabel;
@property(nonatomic,strong) UILabel *textnameLabel;

@property(nonatomic,strong) UILabel *textNumberLabel;
@property(nonatomic,strong) UILabel *textWhereItIsLabel;

@property(nonatomic,strong) UILabel *textRMBLabel;

@property(nonatomic,strong) UIButton *cancelLabel;





@end
@implementation newCurrentProgressSharersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
-(void)setFrame:(CGRect)frame
{
    
    　　　　// 首先我们需要判断是不是ios6之前的版本（含ios6）
    
//    　　　　if([[UIDevice currentDevice].systemVersion doubleValue]>=7.0) return;
    CGRect newFrame=frame;
;
       newFrame.size.width-=20;
       newFrame.origin.y+=10;
    newFrame.origin.x+=10;
    frame=newFrame;
    [super setFrame:frame];
  
    
    　　}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.contentView.layer.cornerRadius=15.f;
        self.contentView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.nameLabel];
        
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.whereItIsLabel];
        [self.contentView addSubview:self.RMBLabel];
        [self.contentView addSubview: self.textnameLabel];
        
        [self.contentView addSubview:self.textNumberLabel];
        
        [self.contentView addSubview:self.textWhereItIsLabel];
        [self.contentView addSubview:self.textRMBLabel];
        [self.contentView addSubview:self.cancelLabel];
        

        
    }
    
    return self;
}

//[self.contentView addSubview:self.nameLabel];
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel =[UILabel gc_labelWithTitle:@"仅为" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:NSTextAlignmentLeft];
        
        
    }
    return _nameLabel;
    
}
//
//[self.contentView addSubview:self.numberLabel];

-(UILabel *)numberLabel{
    
    if (!_numberLabel) {
        _numberLabel =[UILabel gc_labelWithTitle:@"13567777777" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:NSTextAlignmentLeft];
    }
    return _numberLabel;
}

//[self.contentView addSubview:self.whereItIsLabel];

-(UILabel *)whereItIsLabel{
    
    if (!_whereItIsLabel) {
        _whereItIsLabel =[UILabel gc_labelWithTitle:@"微信" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:NSTextAlignmentLeft];
    }
    return _whereItIsLabel;
}

//[self.contentView addSubview:self.RMBLabel];
-(UILabel *)RMBLabel{
    if (!_RMBLabel) {
        _RMBLabel =[UILabel gc_labelWithTitle:@"RMB 644" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:NSTextAlignmentLeft];
    }
    
    return _RMBLabel;
}
//[self.contentView addSubview: self.textnameLabel];
//
-(UILabel *)textnameLabel{
    if (!_textnameLabel) {
        _textnameLabel =[UILabel gc_labelWithTitle:@"微信共享者" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    
    return _textnameLabel;
}

//[self.contentView addSubview:self.textNumberLabel];
-(UILabel *)textNumberLabel{
    if (!_textNumberLabel) {
        _textNumberLabel =[UILabel gc_labelWithTitle:@"共享者微信号" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    
    return _textNumberLabel;
}
//
//[self.contentView addSubview:self.textWhereItIsLabel];
-(UILabel *)textWhereItIsLabel{
    if (!_textWhereItIsLabel) {
        _textWhereItIsLabel =[UILabel gc_labelWithTitle:@"共享者开户行" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    return _textWhereItIsLabel;
}
//[self.contentView addSubview:self.textRMBLabel];

-(UILabel *)textRMBLabel{
    if (!_textRMBLabel) {
        _textRMBLabel =[UILabel gc_labelWithTitle:@"RMB" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    
    return _textRMBLabel;
}
-(UIButton *)cancelLabel{
    if (!_cancelLabel) {
        _cancelLabel =[[UIButton alloc]init];
        [_cancelLabel setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelLabel.backgroundColor =[UIColor yellowColor];
        [_cancelLabel setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        _cancelLabel.layer.cornerRadius=15.f;
        _cancelLabel.layer.masksToBounds=YES;
        [_cancelLabel addTarget:self action:@selector(cancelInfo) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return _cancelLabel;
}
-(void)cancelInfo{
    
    
    
    
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
 
    
    
    [self.textNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textNumberLabel.mas_right).offset(10);
        make.centerY.equalTo(self.textNumberLabel.mas_centerY);
make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@30);
    }];
//

    [self.textnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textNumberLabel.mas_bottom).offset(20);

        make.left.equalTo(self.textNumberLabel.mas_left);

        make.right.equalTo(self.textNumberLabel.mas_right);
        make.height.equalTo(@30);
    }];


    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {


        make.centerY.equalTo(self.textnameLabel.mas_centerY);
        make.left.equalTo(self.numberLabel.mas_left);
        make.right.equalTo(self.numberLabel.mas_right);
        make.height.equalTo(@30);

    }];


    [self.textWhereItIsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textnameLabel.mas_bottom).offset(20);
        make.left.equalTo(self.textnameLabel.mas_left);
        make.right.equalTo(self.textnameLabel.mas_right);
        make.height.equalTo(@30);
    }];
    [self.whereItIsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        make.centerY.equalTo(self.textWhereItIsLabel.mas_centerY);

        make.height.equalTo(@30);
    }];

    [self.textRMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textWhereItIsLabel.mas_bottom).offset(20);
        make.left.equalTo(self.textWhereItIsLabel.mas_left);
        make.right.equalTo(self.textWhereItIsLabel.mas_right);
        make.height.equalTo(@30);

    }];

    [self.cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textRMBLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 30));

    }];

    [self.RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whereItIsLabel.mas_left);
        make.right.equalTo(self.whereItIsLabel.mas_right);
        make.centerY.equalTo(self.textRMBLabel.mas_centerY);
        make.height.equalTo(@30);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

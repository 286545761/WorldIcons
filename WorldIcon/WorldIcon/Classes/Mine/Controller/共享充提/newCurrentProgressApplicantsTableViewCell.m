//
//  newCurrentProgressApplicantsTableViewCell.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressApplicantsTableViewCell.h"
@interface newCurrentProgressApplicantsTableViewCell()

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *RMBLabel;
@property(nonatomic,strong) UILabel *textnameLabel;
@property(nonatomic,strong) UILabel *textRMBLabel;

@end
@implementation newCurrentProgressApplicantsTableViewCell

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
-(void)setAppDic:(NSMutableDictionary *)appDic{
    
    self.RMBLabel.text=[NSString stringWithFormat:@"RMB %@",appDic[@"vra_rmb"]];
    self.nameLabel.text=[NSString stringWithFormat:@"%@",appDic[@"vra_sq_name"]];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.contentView.layer.cornerRadius=15.f;
        self.contentView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.nameLabel];
        
       
       
        [self.contentView addSubview:self.RMBLabel];
        [self.contentView addSubview: self.textnameLabel];
        
       
        
       
        [self.contentView addSubview:self.textRMBLabel];
     
        
        
        
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
        _textnameLabel =[UILabel gc_labelWithTitle:@"申请者账户名" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    
    return _textnameLabel;
}


//[self.contentView addSubview:self.textRMBLabel];

-(UILabel *)textRMBLabel{
    if (!_textRMBLabel) {
        _textRMBLabel =[UILabel gc_labelWithTitle:@"金额" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    
    return _textRMBLabel;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    

    //
    
    [self.textnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.textnameLabel.mas_right).offset(10);
        make.centerY.equalTo(self.textnameLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@30);
        
    }];
    
    
  
    
    [self.textRMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textnameLabel.mas_bottom).offset(20);
        make.left.equalTo(self.textnameLabel.mas_left);
        make.right.equalTo(self.textnameLabel.mas_right);
        make.height.equalTo(@30);
        
    }];
    
    
    [self.RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        make.centerY.equalTo(self.textRMBLabel.mas_centerY);
        make.height.equalTo(@30);
    }];
    
    
}


@end

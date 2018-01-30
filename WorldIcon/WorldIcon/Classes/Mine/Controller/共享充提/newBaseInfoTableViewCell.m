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
//        [self.contentView addSubview: self.bandNameTextView];
        [self.contentView addSubview: self.bandNameTextLable];
        [self.contentView addSubview: self.editorInfoButton];
        [self.contentView addSubview: self.acountLabel];
        [self.contentView addSubview:self.acountNameLabel];
        [self.contentView addSubview: self.localLabel];
    }
    return self;
}
-(UILabel *)localLabel{
    if (!_localLabel) {
        _localLabel =[[UILabel alloc]init];
            _localLabel.text=@"所在省市";
            _localLabel.textColor=[UIColor gc_colorWithHexString:@"#999999"];
            _localLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightBold];
            _localLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _localLabel;
}
-(UILabel *)acountNameLabel{
    if (!_acountNameLabel) {
        _acountNameLabel =[[UILabel alloc]init];
        _acountNameLabel.text=@"账户名字";
        _acountNameLabel.textColor=[UIColor gc_colorWithHexString:@"#999999"];
        _acountNameLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        _acountNameLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _acountNameLabel;
}
-(UILabel *)acountLabel{
    if (!_acountLabel) {
        _acountLabel =[[UILabel alloc]init];
        _acountLabel.text=@"银行账户";
        _acountLabel.textAlignment=NSTextAlignmentLeft;
        _acountLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        _acountLabel.textColor=[UIColor gc_colorWithHexString:@"#999999"];
    }
    
    return _acountLabel;
}
-(UILabel *)bandNameTextLable{
    if (!_bandNameTextLable) {
       _bandNameTextLable =[[UILabel alloc]init];
      _bandNameTextLable.text=@"银行账户";
     _bandNameTextLable.textAlignment=NSTextAlignmentLeft;
        _bandNameTextLable.font=[UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        _bandNameTextLable.textColor=[UIColor gc_colorWithHexString:@"#666666"];
    }
    return _bandNameTextLable;
}
-(UIButton *)editorInfoButton{
    if (!_editorInfoButton) {
        _editorInfoButton =[[UIButton alloc]init];
        [_editorInfoButton setImage:[UIImage imageWithRenderOriginalName:@"my_editor"] forState:UIControlStateNormal];
        [_editorInfoButton addTarget:self action:@selector(editorInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editorInfoButton;
}
-(void)setIndex:(NSIndexPath *)index{
    _index=index;
    if (index.row==1||index.row==2) {
        self.localLabel.alpha=0;
    }else if (index.row==3){
        self.bandNameTextLable.alpha=0.f;
        self.editorInfoButton.alpha=0.f;
        
        
    }else{
        self.bandNameTextLable.alpha=1.f;
        self.editorInfoButton.alpha=1.f;
        
    }
}
// 编辑
-(void)editorInfo{
    if (self.editorBlock) {
        self.editorBlock(self.index);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.bandNameTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    [self.editorInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.editorInfoButton.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.acountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.bandNameTextLable.mas_bottom);
        make.height.equalTo(@30);
    }];
    [self.acountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.acountLabel.mas_bottom);
        make.height.equalTo(@30);
    }];
    [self.localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.acountNameLabel.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    
}
@end

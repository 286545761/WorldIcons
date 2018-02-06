//
//  newCurrentProgressMakeSureMoneyTableViewCell.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressMakeSureMoneyTableViewCell.h"
@interface newCurrentProgressMakeSureMoneyTableViewCell()
@property(strong,nonatomic)UIButton*makeSuerButton;

@property(strong,nonatomic)UIButton*theTermsButton;

@property(strong,nonatomic)UILabel*instructionsLabel;
@property(assign,nonatomic)BOOL isAgreed;

@end
@implementation newCurrentProgressMakeSureMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setFrame:(CGRect)frame{
    CGRect newFrame=frame;
    
    newFrame.size.width-=20;
    newFrame.origin.y+=10;
    newFrame.origin.x+=10;
    frame=newFrame;
    [super setFrame:frame];
    
    
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor clearColor];
        self.contentView.layer.cornerRadius=15.f;
        self.contentView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.makeSuerButton];
        [self.contentView addSubview:self.instructionsLabel];
        [self.contentView addSubview:self.theTermsButton];
        
    }
    return self;
    }


-(UIButton *)makeSuerButton{
    if (!_makeSuerButton) {
        _makeSuerButton =[[UIButton alloc]init];
        
        [_makeSuerButton setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        _makeSuerButton.layer.cornerRadius=15.f;
        _makeSuerButton.layer.masksToBounds=YES;
        [_makeSuerButton setTitle:@"确定" forState:UIControlStateNormal];
        [_makeSuerButton addTarget:self action:@selector(makeSuerEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _makeSuerButton;
}
-(void)makeSuerEvent:(UIButton*)button{
    button.userInteractionEnabled=NO;
    
    if (self.isAgreed) {
        if (self.makeSureBlock) {
            self.makeSureBlock();
        }
    }else{
        
      [MBProgressHUD gc_showErrorMessage:@"同意协议"];
        
        
        
    }
   
    
}
//[self.contentView addSubview:self.instructionsLabel];
-(UILabel *)instructionsLabel{
    
    if (!_instructionsLabel) {
//        @"确认"
        _instructionsLabel =[UILabel gc_labelWithTitle:@"请尽快确认是否收到款" withTextColor:[UIColor redColor] withTextFont:16 withTextAlignment:NSTextAlignmentLeft];
    }
    return _instructionsLabel;
}
//[self.contentView addSubview:self.theTermsButton];
-(UIButton *)theTermsButton{
    if (!_theTermsButton) {
        _theTermsButton =[[UIButton alloc]init];
        [_theTermsButton setTitle:@"同意《欧力币共享冲提协议》" forState:UIControlStateNormal];
        [_theTermsButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _theTermsButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [_theTermsButton setImage:[UIImage imageNamed:@"argry"] forState:UIControlStateSelected];
        _theTermsButton.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
  [_theTermsButton setImage:[UIImage imageNamed:@"unargry"] forState:UIControlStateNormal];
        [_theTermsButton setTitleColor:RGBA(155, 157, 168, 1) forState:UIControlStateNormal];
        [_theTermsButton addTarget:self action:@selector(theTerms:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _theTermsButton;
}
-(void)theTerms:(UIButton*)button{
  
    button.selected=YES;
    button.userInteractionEnabled=NO;
    if (self.agreedBlock) {
        self.agreedBlock();
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.makeSuerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.instructionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.makeSuerButton.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@20);
    }];
    [self.theTermsButton mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.makeSuerButton.mas_right).offset(10);
        make.top.equalTo(self.instructionsLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@210);
    }];
    
    
    
}

@end

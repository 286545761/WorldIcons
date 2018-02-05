//
//  newCurrentProgressTableViewCell.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressTableViewCell.h"



@interface newCurrentProgressTableViewCell ()

@property(nonatomic,strong) UILabel *timeOneLabel;
@property(nonatomic,strong) UILabel *timeTowLabel;


@property(nonatomic,strong) UILabel *instructionsOneLabel;
@property(nonatomic,strong) UILabel *instructionsTowLabel;


@property(nonatomic,strong)UIView *oneView;
@property(nonatomic,strong)UIView *TowView;

@property(nonatomic,strong)UIView *makeView;





@end
@implementation newCurrentProgressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
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
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.contentView.layer.cornerRadius=15.f;
        self.contentView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.timeOneLabel];
        [self.contentView addSubview:self.timeTowLabel];
        [self.contentView addSubview:self.instructionsOneLabel];
        [self.contentView addSubview:self.instructionsTowLabel];
        [self.contentView addSubview:self.oneView];
        [self.contentView addSubview:self.TowView];
        [self.contentView addSubview:self.makeView];
        
      

        
    }
    
    return self;
}

//[self.contentView addSubview:self.timeOneLabel];

-(UILabel *)timeOneLabel{
    if (!_timeOneLabel) {
        _timeOneLabel =[UILabel gc_labelWithTitle:@"2018-02-05 18:49:32" withTextColor:[UIColor redColor] withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    }
    return _timeOneLabel;
}
//[self.contentView addSubview:self.timeTowLabel];

-(UILabel *)timeTowLabel{
    if (!_timeTowLabel) {
        _timeTowLabel =[UILabel gc_labelWithTitle:@"" withTextColor:[UIColor redColor] withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    }
    return _timeTowLabel;
}

//[self.contentView addSubview:self.instructionsOneLabel];
-(UILabel *)instructionsOneLabel{
    if (!_instructionsOneLabel) {
        _instructionsOneLabel =[UILabel gc_labelWithTitle:@"已接单" withTextColor:[UIColor redColor] withTextFont:16 withTextAlignment:NSTextAlignmentLeft];
    }
    return _instructionsOneLabel;
}


//[self.contentView addSubview:self.instructionsTowLabel];
-(UILabel *)instructionsTowLabel{
    if (!_instructionsTowLabel) {
        _instructionsTowLabel =[UILabel gc_labelWithTitle:@"" withTextColor:[UIColor redColor] withTextFont:16 withTextAlignment:NSTextAlignmentLeft];
    }
    return _instructionsTowLabel;
}
//[self.contentView addSubview:self.oneView];
-(UIView *)oneView{
    if (!_oneView) {
        _oneView =[[UIView alloc]init];
        _oneView.backgroundColor =[UIColor redColor];
        _oneView.layer.cornerRadius=8;
        _oneView.layer.masksToBounds=YES;
    }
    return _oneView;
}
//[self.contentView addSubview:self.TowView];
-(UIView *)TowView{
    if (!_TowView) {
        _TowView =[[UIView alloc]init];
        _TowView.backgroundColor =[UIColor redColor];
        _TowView.layer.cornerRadius=8;
        _TowView.layer.masksToBounds=YES;
    }
    return _TowView;
}
//[self.contentView addSubview:self.makeView];
-(UIView *)makeView{
    if (!_makeView) {
        _makeView =[[UIView alloc]init];
        _makeView.backgroundColor =[UIColor redColor];
        
    }
    return _makeView;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
   
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [self.timeOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.oneView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.oneView.mas_left).offset(-10);
        make.height.equalTo(@30);
    }];
    [self.instructionsOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.oneView.mas_centerY);
        make.left.equalTo(self.oneView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@30);
        
    }];
    [self.makeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.oneView.mas_centerX);
        make.top.equalTo(self.oneView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(2, 30));
    }];
    
    [self.TowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.makeView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [self.timeTowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.TowView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.TowView.mas_left).offset(-10);
        make.height.equalTo(@30);
    }];
    [self.instructionsTowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.TowView.mas_centerY);
        make.left.equalTo(self.TowView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@30);
        
    }];
    
    
    
}
@end

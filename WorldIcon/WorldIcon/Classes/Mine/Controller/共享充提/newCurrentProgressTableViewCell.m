//
//  newCurrentProgressTableViewCell.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressTableViewCell.h"
#import "GXCTModel.h"


@interface newCurrentProgressTableViewCell ()

@property(nonatomic,strong) UILabel *timeOneLabel;
@property(nonatomic,strong) UILabel *timeTowLabel;


@property(nonatomic,strong) UILabel *instructionsOneLabel;
@property(nonatomic,strong) UILabel *instructionsTowLabel;


@property(nonatomic,strong)UIView *oneView;
@property(nonatomic,strong)UIView *TowView;

@property(nonatomic,strong)UIView *newMaskViewOf;





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
        [self.contentView addSubview:self.newMaskViewOf];
        
      

        
    }
    
    return self;
}
-(void)setAppArray:(NSMutableArray *)appArray{
    _appArray =appArray;
    
    if (self.appArray.count==1) {
        ReAppStatus *mone=_appArray[0];
        self.oneView.alpha=1.f;
        self.timeOneLabel.alpha=1.f;
        self.timeOneLabel.text=[NSString stringWithFormat:@"%@  %@",mone.vrs_date,mone.vrs_time];
        self.instructionsOneLabel.alpha=1.f;
        self.instructionsOneLabel.text=mone.vrs_info;

        self.TowView.alpha=0.f;
           self.timeTowLabel.alpha=0.f;
        self.instructionsTowLabel.alpha=0.f;
            self.newMaskViewOf.alpha=0.f;
        
        
    }else if (self.appArray.count==2){
        self.oneView.alpha=1.f;
        self.timeOneLabel.alpha=1.f;
        self.instructionsOneLabel.alpha=1.f;
        self.newMaskViewOf.alpha=1.f;
        self.newMaskViewOf.alpha=1.f;
        self.TowView.alpha=1.f;
        self.timeTowLabel.alpha=1.f;
        self.instructionsTowLabel.alpha=1.f;
        ReAppStatus *mone=_appArray[0];
        self.timeOneLabel.text=[NSString stringWithFormat:@"%@  %@",mone.vrs_date,mone.vrs_time];
        self.instructionsOneLabel.text=mone.vrs_info;
        ReAppStatus *mtow=_appArray[0];
        self.timeTowLabel.text=[NSString stringWithFormat:@"%@  %@",mtow.vrs_date,mtow.vrs_time];
        self.instructionsTowLabel.text=mtow.vrs_info;
        
        
    }else{
        self.oneView.alpha=0.f;
        self.timeOneLabel.alpha=0.f;
        self.instructionsOneLabel.alpha=0.f;
        self.newMaskViewOf.alpha=0.f;

        self.TowView.alpha=0.f;
        self.timeTowLabel.alpha=0.f;
        self.instructionsTowLabel.alpha=0.f;
        
    }
    
    
}

//[self.contentView addSubview:self.timeOneLabel];

-(UILabel *)timeOneLabel{
    if (!_timeOneLabel) {
        _timeOneLabel =[UILabel gc_labelWithTitle:@"2018-02-05 18:49:32" withTextColor:[UIColor gc_colorWithHexString:@"#cc3333"] withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    }
    return _timeOneLabel;
}
//[self.contentView addSubview:self.timeTowLabel];

-(UILabel *)timeTowLabel{
    if (!_timeTowLabel) {
        _timeTowLabel =[UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#cc3333"] withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    }
    return _timeTowLabel;
}

//[self.contentView addSubview:self.instructionsOneLabel];
-(UILabel *)instructionsOneLabel{
    if (!_instructionsOneLabel) {
        _instructionsOneLabel =[UILabel gc_labelWithTitle:@"已接单" withTextColor:[UIColor gc_colorWithHexString:@"#cc3333"] withTextFont:16 withTextAlignment:NSTextAlignmentLeft];
    }
    return _instructionsOneLabel;
}


//[self.contentView addSubview:self.instructionsTowLabel];
-(UILabel *)instructionsTowLabel{
    if (!_instructionsTowLabel) {
        _instructionsTowLabel =[UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#cc3333"] withTextFont:16 withTextAlignment:NSTextAlignmentLeft];
    }
    return _instructionsTowLabel;
}
//[self.contentView addSubview:self.oneView];
-(UIView *)oneView{
    if (!_oneView) {
        _oneView =[[UIView alloc]init];
        _oneView.backgroundColor = [UIColor gc_colorWithHexString:@"#cc3333"];
        _oneView.layer.cornerRadius=8;
        _oneView.layer.masksToBounds=YES;
    }
    return _oneView;
}
//[self.contentView addSubview:self.TowView];
-(UIView *)TowView{
    if (!_TowView) {
        _TowView =[[UIView alloc]init];
        _TowView.backgroundColor = [UIColor gc_colorWithHexString:@"#cc3333"];
        _TowView.layer.cornerRadius=8;
        _TowView.layer.masksToBounds=YES;
    }
    return _TowView;
}
//[self.contentView addSubview:self.newMaskViewOf];
-(UIView *)newMaskViewOf{
    if (!_newMaskViewOf) {
        _newMaskViewOf =[[UIView alloc]init];
        _newMaskViewOf.backgroundColor =[UIColor gc_colorWithHexString:@"#cc3333"];
        
    }
    return _newMaskViewOf;
    
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
    [self.newMaskViewOf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.oneView.mas_centerX);
        make.top.equalTo(self.oneView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(2, 30));
    }];
    
    [self.TowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.newMaskViewOf.mas_bottom).offset(5);
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

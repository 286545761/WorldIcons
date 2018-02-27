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
@property(nonatomic,strong) UILabel *timeThreeLabel;
@property(nonatomic,strong) UILabel *timeFourLabel;


@property(nonatomic,strong) UILabel *instructionsOneLabel;
@property(nonatomic,strong) UILabel *instructionsTowLabel;
@property(nonatomic,strong) UILabel *instructionsThreeLabel;
@property(nonatomic,strong) UILabel *instructionsFourLabel;

@property(nonatomic,strong)UIView *oneView;
@property(nonatomic,strong)UIView *TowView;
@property(nonatomic,strong)UIView *ThreeView;
@property(nonatomic,strong)UIView *FourView;
@property(nonatomic,strong)UIView *oneMaskViewOf;
@property(nonatomic,strong)UIView *towMaskViewOf;
@property(nonatomic,strong)UIView *ThreeMaskViewOf;




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
        [self.contentView addSubview:self.oneMaskViewOf];
        [self.contentView addSubview:self.timeThreeLabel];
        [self.contentView addSubview:self.timeFourLabel];
        [self.contentView addSubview:self.instructionsThreeLabel];
        [self.contentView addSubview:self.instructionsFourLabel];
        [self.contentView addSubview:self.ThreeView];
        [self.contentView addSubview:self.FourView];
        [self.contentView addSubview:self.towMaskViewOf];
        [self.contentView addSubview:self.ThreeMaskViewOf];
        
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
            self.oneMaskViewOf.alpha=0.f;
        
        
        
        self.timeThreeLabel.alpha=0.f;
        self.timeFourLabel.alpha=0.f;
        self.instructionsThreeLabel.alpha=0.f;;
        self.instructionsFourLabel.alpha=0.f;
        self.ThreeView.alpha=0.f;
        self.FourView.alpha=0.f;
      self.towMaskViewOf.alpha=0.f;
        self.ThreeMaskViewOf.alpha=0.f;
        
        
        
        
    }else if (self.appArray.count==2){
        self.oneView.alpha=1.f;
        self.timeOneLabel.alpha=1.f;
        self.instructionsOneLabel.alpha=1.f;
        self.oneMaskViewOf.alpha=1.f;
        self.oneMaskViewOf.alpha=1.f;
        self.TowView.alpha=1.f;
        self.timeTowLabel.alpha=1.f;
        self.instructionsTowLabel.alpha=1.f;
        ReAppStatus *mone=_appArray[0];
        self.timeOneLabel.text=[NSString stringWithFormat:@"%@  %@",mone.vrs_date,mone.vrs_time];
        self.instructionsOneLabel.text=mone.vrs_info;
        ReAppStatus *mtow=_appArray[1];
        self.timeTowLabel.text=[NSString stringWithFormat:@"%@  %@",mtow.vrs_date,mtow.vrs_time];
        self.instructionsTowLabel.text=mtow.vrs_info;
        self.timeThreeLabel.alpha=0.f;
        self.timeFourLabel.alpha=0.f;
        self.instructionsThreeLabel.alpha=0.f;;
        self.instructionsFourLabel.alpha=0.f;
        self.ThreeView.alpha=0.f;
        self.FourView.alpha=0.f;
        self.towMaskViewOf.alpha=0.f;
        self.ThreeMaskViewOf.alpha=0.f;
        
        
    }else if (self.appArray.count==3){
        
        
        self.oneView.alpha=1.f;
        self.timeOneLabel.alpha=1.f;
        self.instructionsOneLabel.alpha=1.f;
        self.oneMaskViewOf.alpha=1.f;
        self.oneMaskViewOf.alpha=1.f;
        self.TowView.alpha=1.f;
        self.timeTowLabel.alpha=1.f;
        self.instructionsTowLabel.alpha=1.f;
        ReAppStatus *mone=_appArray[0];
        self.timeOneLabel.text=[NSString stringWithFormat:@"%@  %@",mone.vrs_date,mone.vrs_time];
        self.instructionsOneLabel.text=mone.vrs_info;
        ReAppStatus *mtow=_appArray[1];
        self.timeTowLabel.text=[NSString stringWithFormat:@"%@  %@",mtow.vrs_date,mtow.vrs_time];
        self.instructionsTowLabel.text=mtow.vrs_info;
        
        ReAppStatus *ttow=_appArray[2];

        
        
        self.timeThreeLabel.alpha=1.f;
       self.timeThreeLabel.text= [NSString stringWithFormat:@"%@  %@",ttow.vrs_date,ttow.vrs_time];
        self.instructionsThreeLabel.text=ttow.vrs_info;
             self.instructionsThreeLabel.alpha=1.f;
         self.ThreeView.alpha=1.f;
                self.towMaskViewOf.alpha=1.f;
     
   
        self.instructionsFourLabel.alpha=0.f;
          self.timeFourLabel.alpha=0.f;
        self.FourView.alpha=0.f;
        self.ThreeMaskViewOf.alpha=0.f;
        
        
        
        
        
    }else if (self.appArray.count==4){
        
        self.oneView.alpha=1.f;
        self.timeOneLabel.alpha=1.f;
        self.instructionsOneLabel.alpha=1.f;
        self.oneMaskViewOf.alpha=1.f;
        self.oneMaskViewOf.alpha=1.f;
        self.TowView.alpha=1.f;
        self.timeTowLabel.alpha=1.f;
        self.instructionsTowLabel.alpha=1.f;
        ReAppStatus *mone=_appArray[0];
        self.timeOneLabel.text=[NSString stringWithFormat:@"%@  %@",mone.vrs_date,mone.vrs_time];
        self.instructionsOneLabel.text=mone.vrs_info;
        ReAppStatus *mtow=_appArray[1];
        self.timeTowLabel.text=[NSString stringWithFormat:@"%@  %@",mtow.vrs_date,mtow.vrs_time];
        self.instructionsTowLabel.text=mtow.vrs_info;
        
        ReAppStatus *mthree=_appArray[2];
        self.timeThreeLabel.alpha=1.f;
        self.timeThreeLabel.text= [NSString stringWithFormat:@"%@  %@",mthree.vrs_date,mthree.vrs_time];
        self.instructionsThreeLabel.text=mthree.vrs_info;
        self.instructionsThreeLabel.alpha=1.f;
        self.ThreeView.alpha=1.f;
        self.towMaskViewOf.alpha=1.f;
         ReAppStatus *mFour=_appArray[3];
       self.timeFourLabel.text= [NSString stringWithFormat:@"%@  %@",mFour.vrs_date,mFour.vrs_time];
        self.instructionsFourLabel.text=mFour.vrs_info;
        self.instructionsFourLabel.alpha=1.f;
        self.timeFourLabel.alpha=1.f;
        self.FourView.alpha=1.f;
        self.ThreeMaskViewOf.alpha=1.f;
        
        
        
        
        
    }else{
        self.oneView.alpha=0.f;
        self.timeOneLabel.alpha=0.f;
        self.instructionsOneLabel.alpha=0.f;
        self.oneMaskViewOf.alpha=0.f;
        self.TowView.alpha=0.f;
        self.timeTowLabel.alpha=0.f;
        self.instructionsTowLabel.alpha=0.f;
        self.timeThreeLabel.alpha=0.f;
        self.timeFourLabel.alpha=0.f;
        self.instructionsThreeLabel.alpha=0.f;;
        self.instructionsFourLabel.alpha=0.f;
        self.ThreeView.alpha=0.f;
        self.FourView.alpha=0.f;
        self.towMaskViewOf.alpha=0.f;
        self.ThreeMaskViewOf.alpha=0.f;
        
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
//[self.contentView addSubview:self.oneMaskViewOf];
-(UIView *)oneMaskViewOf{
    if (!_oneMaskViewOf) {
        _oneMaskViewOf =[[UIView alloc]init];
        _oneMaskViewOf.backgroundColor =[UIColor gc_colorWithHexString:@"#cc3333"];
        
    }
    return _oneMaskViewOf;
    
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
    [self.oneMaskViewOf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.oneView.mas_centerX);
        make.top.equalTo(self.oneView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(2, 30));
    }];
    
    [self.TowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.oneMaskViewOf.mas_bottom).offset(5);
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

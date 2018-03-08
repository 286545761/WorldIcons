//
//  MyIncomeCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/3/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "MyIncomeCell.h"
#import "IncomeModel.h"
@interface MyIncomeCell ()
@property(nonatomic,strong)UILabel *bottomLineL;
@property(nonatomic,strong)UILabel *numberL;
@property(nonatomic,strong)UILabel *unitL;
@property(nonatomic,strong)UILabel *levelL;
@end
@implementation MyIncomeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = KBackgroundColor;
        self.backgroundColor = KBackgroundColor;
        UIView *back = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 320-20, 40)];
        back.layer.cornerRadius = 5;
        back.layer.masksToBounds = YES;
        back.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:back];
        
        self.bottomLineL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0,10, back.adaptiveIphone5Frame.size.width/4.0f, 20)];
        self.bottomLineL.text = @"下线";
        self.bottomLineL.textAlignment = NSTextAlignmentCenter;
        self.bottomLineL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        self.bottomLineL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        [back addSubview:self.bottomLineL];
        
        self.numberL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.bottomLineL.adaptiveIphone5Frame.origin.x+self.bottomLineL.adaptiveIphone5Frame.size.width, self.bottomLineL.adaptiveIphone5Frame.origin.y, back.adaptiveIphone5Frame.size.width/4.0f, 20)];
        self.numberL.text = @"数量";
        self.numberL.textAlignment = NSTextAlignmentCenter;
        self.numberL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        self.numberL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        [back addSubview:self.numberL];
        
        self.levelL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.numberL.adaptiveIphone5Frame.origin.x+self.numberL.adaptiveIphone5Frame.size.width, self.bottomLineL.adaptiveIphone5Frame.origin.y, back.adaptiveIphone5Frame.size.width/4.0f, 20)];
        self.levelL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        self.levelL.text = @"等级";
        self.levelL.textAlignment = NSTextAlignmentCenter;
        self.levelL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        [back addSubview:self.levelL];
        
        self.unitL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.levelL.adaptiveIphone5Frame.origin.x+self.levelL.adaptiveIphone5Frame.size.width, self.bottomLineL.adaptiveIphone5Frame.origin.y, back.adaptiveIphone5Frame.size.width/4.0f, 20)];
        self.unitL.text = @"单位";
        self.unitL.textAlignment = NSTextAlignmentCenter;
        self.unitL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        self.unitL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        [back addSubview:self.unitL];
        
    }
    return self;
}

-(void)reloadCellModel:(IncomeModel *)model{
    self.bottomLineL.text = model.vi_from_ub_nn;
    self.numberL.text = model.vi_income;
    self.levelL.text = model.vi_level;
    self.unitL.text = model.vi_unit;
}

+(CGFloat)getCellHeight{
    return [UIView countBeforeWithIphone5Length:50];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

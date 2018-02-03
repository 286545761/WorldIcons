//
//  entrustTableViewCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/3.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "entrustTableViewCell.h"
#import "PriceModel.h"
@interface entrustTableViewCell()
@property(nonatomic,strong)UILabel *timeL;
@property(nonatomic,strong)UILabel *priceL;
@property(nonatomic,strong)UILabel *entrustTypeL;
@property(nonatomic,strong)UILabel *stateL;
@end
@implementation entrustTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        UIView *back = [[UIView alloc
                         ]initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 300, 50)];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 5;
        [self.contentView addSubview:back];
        
        
        _timeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 300/4, 50)];
        _timeL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        _timeL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _timeL.textAlignment = NSTextAlignmentCenter;
        _timeL.numberOfLines = 2;
        _timeL.text = @"2018-01-03 16:39:50";
        [back addSubview:_timeL];
        
        _priceL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(_timeL.adaptiveIphone5Frame.origin.x+_timeL.adaptiveIphone5Frame.size.width, 0, 300/4, 50)];
        _priceL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        _priceL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _priceL.textAlignment = NSTextAlignmentCenter;
        _priceL.numberOfLines = 2;
        _priceL.text = @"9465858\n1.03";
        [back addSubview:_priceL];
        
        _entrustTypeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(_priceL.adaptiveIphone5Frame.origin.x+_priceL.adaptiveIphone5Frame.size.width, 0, 300/4, 50)];
        _entrustTypeL.textColor = [UIColor redColor];
        _entrustTypeL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _entrustTypeL.textAlignment = NSTextAlignmentCenter;
        _entrustTypeL.text = @"买入";
        [back addSubview:_entrustTypeL];
        
        _stateL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(_entrustTypeL.adaptiveIphone5Frame.origin.x+_entrustTypeL.adaptiveIphone5Frame.size.width, 0, 300/4, 50)];
        _stateL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        _stateL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _stateL.textAlignment = NSTextAlignmentCenter;
        _stateL.text = @"部分交易";
        [back addSubview:_stateL];
    }
    return self;
}

-(void)reloadCellModel:(BuySellModel *)model{
    _timeL.text = [NSString stringWithFormat:@"%@\n%@",model.vb_date,model.vb_time];
    _priceL.text = [NSString stringWithFormat:@"%@\n%@",model.vb_count,model.vb_b];
    if ([model.type isEqualToString:@"1"]) {
        _entrustTypeL.text = @"买入";
        _entrustTypeL.textColor = [UIColor redColor];
    }
    if ([model.type isEqualToString:@"2"]) {
        _entrustTypeL.text = @"卖出";
        _entrustTypeL.textColor = [UIColor greenColor];
    }
    
    _stateL.text = model.vb_info;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

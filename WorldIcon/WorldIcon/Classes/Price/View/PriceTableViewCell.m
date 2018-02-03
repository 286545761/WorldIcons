//
//  PriceTableViewCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/3.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "PriceTableViewCell.h"
#import "PriceModel.h"
@interface PriceTableViewCell()
@property(nonatomic,strong)UILabel *leftL;
@property(nonatomic,strong)UILabel *priceL;
@property(nonatomic,strong)UILabel *numberL;
@property(nonatomic,strong)UIImageView *progressImg;
@end
@implementation PriceTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        UIView *back = [[UIView alloc
                         ]initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 300, 30)];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 3;
        [self.contentView addSubview:back];
        
        
        _leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 25, 30)];
        _leftL.textColor = [UIColor gc_colorWithHexString:@"#999999"];
        _leftL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _leftL.textAlignment = NSTextAlignmentCenter;
        _leftL.text = @"卖5";
        [back addSubview:_leftL];
        
        _priceL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(_leftL.adaptiveIphone5Frame.origin.x+_leftL.adaptiveIphone5Frame.size.width+30, 0, 90, 30)];
        _priceL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        _priceL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _priceL.textAlignment = NSTextAlignmentLeft;
        _priceL.text = @"1.05";
        [back addSubview:_priceL];
        
        _numberL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(300/2-40, 0, 55, 30)];
        _numberL.textColor = [UIColor gc_colorWithHexString:@"#999999"];
        _numberL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _numberL.textAlignment = NSTextAlignmentRight;
        _numberL.text = @"1.05";
        [back addSubview:_numberL];
        
        _progressImg = [[UIImageView alloc]initWithAdaptiveIphone5Frame:CGRectMake(_numberL.adaptiveIphone5Frame.origin.x+_numberL.adaptiveIphone5Frame.size.width+10, 10, 300-10-_numberL.adaptiveIphone5Frame.origin.x-_numberL.adaptiveIphone5Frame.size.width, 10)];
        _progressImg.image = [UIImage imageNamed:@"sellBtn"];
//        _progressImg.contentMode = UIViewContentModeScaleAspectFit;
        [back addSubview:_progressImg];
        
        self.whiteV = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 10, 300, 10)];
        self.whiteV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.whiteV];
        [self.contentView bringSubviewToFront:back];
    }
    return self;
}

-(void)reloadCellBuyModel:(BuyModel *)model
            withIndexpath:(NSIndexPath *)index{
    self.leftL.text = [NSString stringWithFormat:@"买%ld",index.row+1];
    self.priceL.text = model.vb_b;
    self.numberL.text = model.vb_b;
    self.progressImg.image = [UIImage imageNamed:@"buyBtn"];
    CGFloat width = [UIView countBeforeWithIphone5Length:300-10-10-10]-_numberL.adaptiveIphone5Frame.origin.x-_numberL.adaptiveIphone5Frame.size.width;
    self.progressImg.adaptiveIphone5Frame = CGRectMake(_numberL.adaptiveIphone5Frame.origin.x+_numberL.adaptiveIphone5Frame.size.width+10, 10, width * ([model.num floatValue]/self.max), 10);
}

-(void)reloadCellSellModel:(SellModel *)model
             withIndexpath:(NSInteger )index{
    self.leftL.text = [NSString stringWithFormat:@"卖%ld",index];
    self.priceL.text = model.vs_s;
    self.numberL.text = model.vs_s;
    self.progressImg.image = [UIImage imageNamed:@"sellBtn"];
    CGFloat width = [UIView countBeforeWithIphone5Length:300-10-10-10]-_numberL.adaptiveIphone5Frame.origin.x-_numberL.adaptiveIphone5Frame.size.width;
    self.progressImg.adaptiveIphone5Frame = CGRectMake(_numberL.adaptiveIphone5Frame.origin.x+_numberL.adaptiveIphone5Frame.size.width+10, 10,width * ([model.num floatValue]/self.max) , 10);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

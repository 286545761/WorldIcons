//
//  BTCShowCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/29.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BTCShowCell.h"
#import "BTCPriceModel.h"
@interface BTCShowCell()
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *priceUSDL;
@property(nonatomic,strong)UILabel *priceBTCL;
@property(nonatomic,strong)UILabel *priceL;
@property(nonatomic,strong)UILabel *changeL;
@end
@implementation BTCShowCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setUpView{
    //消息类别
    _nameL = [UILabel gc_labelWithTitle:@"BTC" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    _nameL.frame = CGRectMake(10, 0, 40, [UIView countBeforeWithIphone5Length:30]);
    _nameL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [self.contentView addSubview:_nameL];
    
    //消息类别
    _priceUSDL = [UILabel gc_labelWithTitle:@"123920483" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    _priceUSDL.frame = CGRectMake(_nameL.frame.origin.x+_nameL.frame.size.width, 0, (kScreenWidth-_nameL.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30]);
    _priceUSDL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [self.contentView addSubview:_priceUSDL];
    
    //消息类别
    _priceBTCL = [UILabel gc_labelWithTitle:@"1" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    _priceBTCL.frame = CGRectMake(_priceUSDL.frame.origin.x+_priceUSDL.frame.size.width, 0, (kScreenWidth-_nameL.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30]);
    _priceBTCL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [self.contentView addSubview:_priceBTCL];
    
    //消息类别
    _priceL = [UILabel gc_labelWithTitle:@"$1314" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    _priceL.frame = CGRectMake(_priceBTCL.frame.origin.x+_priceBTCL.frame.size.width, 0, (kScreenWidth-_nameL.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30]);
    _priceL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [self.contentView addSubview:_priceL];
    
    //消息类别
    _changeL = [UILabel gc_labelWithTitle:@"-1214" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    _changeL.frame = CGRectMake(_priceL.frame.origin.x+_priceL.frame.size.width, 0, (kScreenWidth-_nameL.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30]);
    _changeL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [self.contentView addSubview:_changeL];
}

-(void)reloadCell:(BTCPriceModel *)model{
    if (model.ve_name_ch.length == 0) {
        _nameL.text = @"";
    }else
        _nameL.text = model.ve_name_ch;
    
    if (model.ve_price_usd.length == 0) {
        _priceUSDL.text = @"";
    }else
        _priceUSDL.text = model.ve_price_usd;
    
    if (model.ve_price_btc.length == 0) {
        _priceBTCL.text = @"";
    }else
        _priceBTCL.text = model.ve_price_btc;
    
    if (model.ve_sz.length == 0) {
        _priceL.text = @"";
    }else
        _priceL.text = model.ve_sz;
    
    if (model.ve_zdf_day.length == 0) {
        _changeL.text = @"";
    }else
        _changeL.text = model.ve_zdf_day;
    if ([model.ve_zdf_day containsString:@"-"]) {
        _changeL.textColor = [UIColor gc_colorWithHexString:@"#129561"];
    }else{
        _changeL.textColor = [UIColor gc_colorWithHexString:@"#cc3333"];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

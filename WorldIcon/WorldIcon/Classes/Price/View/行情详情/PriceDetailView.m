//
//  PriceDetailView.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/2.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "PriceDetailView.h"
#import "PriceModel.h"
@interface PriceDetailView()
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *typeL;
@property(nonatomic,strong)UILabel *totalPriceL;
@property(nonatomic,strong)UILabel *priceL;
@property(nonatomic,strong)UILabel *timeL;
@property(nonatomic,strong)UILabel *numberL;
@property(nonatomic,strong)UILabel *stateL;
@end
@implementation PriceDetailView

-(instancetype)initWithBuyModel:(BuySellModel *)model{
    self = [super init];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.3f);
        [self initViewWithBuyModel:model];
    }
    return self;
}
-(instancetype)initWithListModel:(ListModel *)model{
    self = [super init];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.3f);
        [self initViewWithListModel:model];
    }
    return self;
}


-(void)initViewWithBuyModel:(BuySellModel *)model{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 568.0f/2-140, 320-20-20, 280)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 20;
    back.layer.masksToBounds = YES;
    [self addSubview:back];
    
    UIImageView *topV = [[UIImageView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 35)];
    topV.image = [UIImage imageNamed:@"backb"];
    [back addSubview:topV];
    
    UILabel *topL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, back.adaptiveIphone5Frame.size.width, 15)];
    topL.text = @"提示";
    topL.textAlignment = NSTextAlignmentCenter;
    topL.font = [UIFont boldSystemFontOfSize:17];
    topL.textColor = [UIColor whiteColor];
    [back addSubview:topL];
    
    self.nameL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+20, 150, 15)];
    self.nameL.textAlignment = NSTextAlignmentLeft;
    self.nameL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.nameL.text = @"名称：欧力币";
    self.nameL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    [back addSubview:self.nameL];
    
    self.typeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.nameL.adaptiveIphone5Frame.origin.y+self.nameL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.typeL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.typeL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.typeL.text = @"操作：撤销";
    self.typeL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.typeL];
    
    self.totalPriceL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.typeL.adaptiveIphone5Frame.origin.y+self.typeL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.totalPriceL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.totalPriceL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    if ([model.type isEqualToString:@"1"]) {
        self.totalPriceL.text = @"委托类型：买入";
    }
    
    if ([model.type isEqualToString:@"2"]) {
        self.totalPriceL.text = @"委托类型：买入";
    }
    
    self.totalPriceL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.totalPriceL];
    
    self.timeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.totalPriceL.adaptiveIphone5Frame.origin.y+self.totalPriceL.adaptiveIphone5Frame.size.height+10, 250, 15)];
    self.timeL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.timeL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.timeL.text = [NSString stringWithFormat:@"委托时间：%@", model.datetime];
    self.timeL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.timeL];
    
    self.priceL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.timeL.adaptiveIphone5Frame.origin.y+self.timeL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.priceL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.priceL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.priceL.text = [NSString stringWithFormat:@"委托价格：%@",model.vb_b];
    self.priceL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.priceL];
    
    self.numberL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.priceL.adaptiveIphone5Frame.origin.y+self.priceL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.numberL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.numberL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.numberL.text = [NSString stringWithFormat:@"成交数量：%@",model.vb_count];
    self.numberL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.numberL];
    
    self.stateL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.numberL.adaptiveIphone5Frame.origin.y+self.numberL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.stateL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.stateL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.stateL.text = [NSString stringWithFormat:@"状态：%@",model.vb_info];
    self.stateL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.stateL];
    
    UIView *line = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, back.adaptiveIphone5Frame.size.height-35, back.adaptiveIphone5Frame.size.width, 1)];
    line.backgroundColor = RGBA(230, 230, 230, 1);
    [back addSubview:line];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.adaptiveIphone5Frame = CGRectMake(0, back.adaptiveIphone5Frame.size.height-35, back.adaptiveIphone5Frame.size.width/2.0f, 35);
    [cancleBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:cancleBtn];
    
    UIButton *revokeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    revokeBtn.adaptiveIphone5Frame = CGRectMake(back.adaptiveIphone5Frame.size.width/2.0f, back.adaptiveIphone5Frame.size.height-35, back.adaptiveIphone5Frame.size.width/2.0f, 35);
    [revokeBtn setTitle:@"撤销" forState:UIControlStateNormal];
    [revokeBtn setTitleColor:[UIColor gc_colorWithHexString:@"#c96705"] forState:UIControlStateNormal];
    revokeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [revokeBtn addTarget:self action:@selector(revokeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:revokeBtn];
}

-(void)initViewWithListModel:(ListModel *)model{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 568.0f/2-140, 320-20-20, 280)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 20;
    back.layer.masksToBounds = YES;
    [self addSubview:back];
    
    UIImageView *topV = [[UIImageView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 35)];
    topV.image = [UIImage imageNamed:@"backb"];
    [back addSubview:topV];
    
    UILabel *topL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, back.adaptiveIphone5Frame.size.width, 15)];
    topL.text = @"详情";
    topL.textAlignment = NSTextAlignmentCenter;
    topL.font = [UIFont boldSystemFontOfSize:17];
    topL.textColor = [UIColor whiteColor];
    [back addSubview:topL];
    
    self.nameL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+20, 150, 15)];
    self.nameL.textAlignment = NSTextAlignmentLeft;
    self.nameL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.nameL.text = @"名称：欧力币";
    self.nameL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    [back addSubview:self.nameL];
    
    self.typeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.nameL.adaptiveIphone5Frame.origin.y+self.nameL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.typeL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.typeL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.typeL.text = @"成交类型：";
    self.typeL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.typeL];
    
    self.totalPriceL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.typeL.adaptiveIphone5Frame.origin.y+self.typeL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.totalPriceL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.totalPriceL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.totalPriceL.text = [NSString stringWithFormat:@"总金额：%@",model.vsb_fee];
    self.totalPriceL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.totalPriceL];
    
    self.timeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.totalPriceL.adaptiveIphone5Frame.origin.y+self.totalPriceL.adaptiveIphone5Frame.size.height+10, 200, 15)];
    self.timeL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.timeL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.timeL.text = [NSString stringWithFormat:@"成交时间：%@",model.vsb_time];
    self.timeL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.timeL];
    
    self.priceL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.timeL.adaptiveIphone5Frame.origin.y+self.timeL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.priceL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.priceL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.priceL.text = [NSString stringWithFormat:@"成交价格：%@",model.vsb_sb];
    self.priceL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.priceL];
    
    self.numberL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.priceL.adaptiveIphone5Frame.origin.y+self.priceL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.numberL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.numberL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.numberL.text = [NSString stringWithFormat:@"成交数量：%@",model.vsb_sbc];
    self.numberL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.numberL];
    
    self.stateL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.nameL.adaptiveIphone5Frame.origin.x, self.numberL.adaptiveIphone5Frame.origin.y+self.numberL.adaptiveIphone5Frame.size.height+10, 150, 15)];
    self.stateL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.stateL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    NSString *str;
    if ([model.vsb_status isEqualToString:@"0"]) {
        str = @"撤销";
    }
    if ([model.vsb_status isEqualToString:@"1"]) {
        str = @"等待交易";
    }
    if ([model.vsb_status isEqualToString:@"2"]) {
        str = @"部分交易";
    }
    if ([model.vsb_status isEqualToString:@"3"]) {
        str = @"全部交易";
    }
    if ([model.vsb_status isEqualToString:@"4"]) {
        str = @"委托失败";
    }
    self.stateL.text = [NSString stringWithFormat:@"状态：%@",str];
    self.stateL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.stateL];
    
    UIView *line = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, back.adaptiveIphone5Frame.size.height-35, back.adaptiveIphone5Frame.size.width, 1)];
    line.backgroundColor = RGBA(230, 230, 230, 1);
    [back addSubview:line];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.adaptiveIphone5Frame = CGRectMake(0, back.adaptiveIphone5Frame.size.height-35, back.adaptiveIphone5Frame.size.width, 35);
    [cancleBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:cancleBtn];
}

-(void)cancleBtnAction{
    if ([self.delegate respondsToSelector:@selector(bottomPassBtnOnClick)]) {
        [self.delegate bottomPassBtnOnClick];
    }
}

-(void)revokeBtnAction{
    if ([self.delegate respondsToSelector:@selector(revokeBtnOnClick:)]) {
        [self.delegate revokeBtnOnClick:self.index];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

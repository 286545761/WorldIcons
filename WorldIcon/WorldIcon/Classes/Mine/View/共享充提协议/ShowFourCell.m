//
//  ShowFourCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "ShowFourCell.h"
@interface ShowFourCell()
@property(nonatomic,strong)UILabel *lineOneL;
@property(nonatomic,strong)UILabel *lineTwoL;
@property(nonatomic,strong)UILabel *showOneL;
@property(nonatomic,strong)UILabel *showTwoL;
@end
@implementation ShowFourCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _topV = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 320-20, 5)];
        _topV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_topV];
        
        _bottomV = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 45, 320-20, 5)];
        _bottomV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bottomV];
        
        UIView *back = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 320-20, 85)];
        back.layer.cornerRadius = 5;
        back.layer.masksToBounds = YES;
        back.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:back];
        
        UILabel *topL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 10, 80, 15)];
        topL.textColor = [UIColor redColor];
        topL.textAlignment = NSTextAlignmentRight;
        CGSize s = [tool characterAdaption:@"手续费和" withFont:[UIFont fontWithAdaptiveIphone5Size:14]];
        topL.adaptiveIphone5Frame = CGRectMake(20, 10, [UIView countIphone5LengthWithBeforeLength:s.width], 15);
        topL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        topL.text = @"*备注";
        [back addSubview:topL];
        
        self.showOneL = [[UILabel alloc] initWithAdaptiveIphone5Frame:CGRectMake(20, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, 80, 15)];
        self.showOneL.textAlignment = NSTextAlignmentRight;
        self.showOneL.text = @"手续费";
        CGSize size = [tool characterAdaption:@"手续费和" withFont:[UIFont fontWithAdaptiveIphone5Size:15]];
        self.showOneL.adaptiveIphone5Frame = CGRectMake(5, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, [UIView countIphone5LengthWithBeforeLength:size.width]+15, 15);
        self.showOneL.font = [UIFont fontWithAdaptiveIphone5Size:12];
        self.showOneL.text = @"手续费公式";
        self.showOneL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [back addSubview:self.showOneL];
        
        self.lineOneL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.showOneL.adaptiveIphone5Frame.origin.x+self.showOneL.adaptiveIphone5Frame.size.width+10, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, 320-20-self.showOneL.adaptiveIphone5Frame.origin.x-self.showOneL.adaptiveIphone5Frame.size.width-10, 15)];
        self.lineOneL.textAlignment = NSTextAlignmentLeft;
        self.lineOneL.text = @"充值金额*0.005(手续费率)";
        self.lineOneL.font = [UIFont fontWithAdaptiveIphone5Size:12];
        self.lineOneL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        [back addSubview:self.lineOneL];
        
        self.showTwoL = [[UILabel alloc] initWithAdaptiveIphone5Frame:CGRectMake(5, self.lineOneL.adaptiveIphone5Frame.origin.y+self.lineOneL.adaptiveIphone5Frame.size.height+10, 80, 15)];
        self.showTwoL.textAlignment = NSTextAlignmentRight;
        self.showTwoL.text = @"手续费";
        CGSize si = [tool characterAdaption:@"手续费和" withFont:[UIFont fontWithAdaptiveIphone5Size:15]];
        self.showTwoL.adaptiveIphone5Frame = CGRectMake(0, self.lineOneL.adaptiveIphone5Frame.origin.y+self.lineOneL.adaptiveIphone5Frame.size.height+10, [UIView countIphone5LengthWithBeforeLength:si.width]+25, 15);
        self.showTwoL.font = [UIFont fontWithAdaptiveIphone5Size:12];
        self.showTwoL.text = @"人民币转换公式";
        self.showTwoL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [back addSubview:self.showTwoL];
        
        self.lineTwoL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.showTwoL.adaptiveIphone5Frame.origin.x+self.showTwoL.adaptiveIphone5Frame.size.width+5, self.lineOneL.adaptiveIphone5Frame.origin.y+self.lineOneL.adaptiveIphone5Frame.size.height+10, 320-self.showTwoL.adaptiveIphone5Frame.origin.x-self.showTwoL.adaptiveIphone5Frame.size.width-10, 15)];
        self.lineTwoL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
        self.lineTwoL.font = [UIFont fontWithAdaptiveIphone5Size:12];
        self.lineTwoL.text = @"(1+0.005(手续费率))*充值金额*美元汇率";
        self.lineTwoL.textAlignment = NSTextAlignmentLeft;
        [back addSubview:self.lineTwoL];
    }
    return self;
}
-(void)reloadView:(NSArray *)arr{
//    self.showOneL.text = arr[0];
//    self.showTwoL.text = arr[1];
    self.lineOneL.text = arr[2];
    self.lineTwoL.text = arr[3];
}

+(CGFloat)getCellHeight{
    return [UIView countBeforeWithIphone5Length:85];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

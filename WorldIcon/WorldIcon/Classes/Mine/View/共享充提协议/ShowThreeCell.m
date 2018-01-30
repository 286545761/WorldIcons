//
//  ShowThreeCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "ShowThreeCell.h"
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
#define KMaxLength     100
@interface ShowThreeCell()
@property(nonatomic,strong)UILabel *leftL;
@property(nonatomic,strong)UILabel *numberL;
@property(nonatomic,strong)UILabel *rightL;
@property(nonatomic,strong)UILabel *inputField;

@end
@implementation ShowThreeCell

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
        
        _bottomV = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 30, 320-20, 5)];
        _bottomV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bottomV];
        
        UIView *back = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 320-20, 35)];
        back.layer.cornerRadius = 5;
        back.layer.masksToBounds = YES;
        back.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:back];
        
        self.leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 10, 80, 15)];
        self.leftL.textAlignment = NSTextAlignmentRight;
        self.leftL.text = @"手续费";
        CGSize s = [tool characterAdaption:@"手续费和" withFont:[UIFont fontWithAdaptiveIphone5Size:14]];
        self.leftL.adaptiveIphone5Frame = CGRectMake(20, 10, [UIView countIphone5LengthWithBeforeLength:s.width], 15);
        self.leftL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        self.leftL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [back addSubview:self.leftL];
        
        _inputField = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.leftL.adaptiveIphone5Frame.origin.x+self.leftL.adaptiveIphone5Frame.size.width+10, 10, 100, 15)];
        _inputField.backgroundColor = [UIColor redColor];
        _inputField.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _inputField.font = [UIFont fontWithAdaptiveIphone5Size:14];
        [back addSubview:_inputField];
        
        _numberL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.inputView.adaptiveIphone5Frame.origin.x+self.inputView.adaptiveIphone5Frame.size.width+10, self.leftL.adaptiveIphone5Frame.origin.y, back.adaptiveIphone5Frame.size.width-self.leftL.adaptiveIphone5Frame.origin.x-self.leftL.adaptiveIphone5Frame.size.width-10-100-100, 15)];
        _numberL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _numberL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        _numberL.textAlignment = NSTextAlignmentRight;
        _numberL.backgroundColor = [UIColor clearColor];
        [back addSubview:_numberL];
        
        _rightL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(_numberL.adaptiveIphone5Frame.origin.x+_numberL.adaptiveIphone5Frame.size.width+10, _numberL.adaptiveIphone5Frame.origin.y, back.adaptiveIphone5Frame.size.width-_numberL.adaptiveIphone5Frame.origin.x-_numberL.adaptiveIphone5Frame.size.width-30-10, 15)];
        _rightL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _rightL.text = @"美元";
        _rightL.textAlignment = NSTextAlignmentRight;
        _rightL.font = [UIFont fontWithAdaptiveIphone5Size:14];
        [back addSubview:_rightL];
    }
    return self;
}


+(CGFloat)getCellHeight{
    return [UIView countBeforeWithIphone5Length:35];
}

-(void)reloadView:(NSArray *)arr{
    self.leftL.text = arr[0];
    self.inputField.text = arr[1];
    self.rightL.text = arr[2];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

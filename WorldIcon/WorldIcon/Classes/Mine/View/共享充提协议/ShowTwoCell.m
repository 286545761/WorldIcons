//
//  ShowTwoCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "ShowTwoCell.h"
@interface ShowTwoCell()
@property(nonatomic,strong)UILabel *leftL;
@property(nonatomic,strong)UITextField *inputField;
@end
@implementation ShowTwoCell

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
        
        UIView *back = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(10, 0, 320-20, 50)];
        back.layer.cornerRadius = 5;
        back.layer.masksToBounds = YES;
        back.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:back];
        
        self.leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 17.5f, 80, 15)];
        self.leftL.textAlignment = NSTextAlignmentRight;
        self.leftL.text = @"充值方式";
        CGSize s = [tool characterAdaption:self.leftL.text withFont:[UIFont fontWithAdaptiveIphone5Size:15]];
        self.leftL.adaptiveIphone5Frame = CGRectMake(20, 17.5f, [UIView countIphone5LengthWithBeforeLength:s.width], 15);
        self.leftL.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.leftL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [back addSubview:self.leftL];
        
        _inputField = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.leftL.adaptiveIphone5Frame.origin.x+self.leftL.adaptiveIphone5Frame.size.width+10, 10, back.adaptiveIphone5Frame.size.width-self.leftL.adaptiveIphone5Frame.origin.x-self.leftL.adaptiveIphone5Frame.size.width-10-70, 30)];
        _inputField.layer.cornerRadius = [UIView countBeforeWithIphone5Length:30]/2.0f;
        _inputField.layer.masksToBounds = YES;
        _inputField.backgroundColor = [UIColor gc_colorWithHexString:@"#e6e8f3"];
        [_inputField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
        _inputField.keyboardType = UIKeyboardTypeNumberPad;
        UILabel *dollors = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 25, 15)];
        dollors.textAlignment = NSTextAlignmentCenter;
        dollors.text = @"$";
        dollors.font = [UIFont fontWithAdaptiveIphone5Size:15];
        dollors.textColor = [UIColor gc_colorWithHexString:@"#999999"];
        _inputField.leftView = dollors;
        _inputField.leftViewMode = UITextFieldViewModeAlways;
        _inputField.placeholder = @"输入金额";
        _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputField.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _inputField.font = [UIFont fontWithAdaptiveIphone5Size:15];
        [back addSubview:_inputField];
        
        UILabel *rightL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(_inputField.adaptiveIphone5Frame.origin.x+_inputField.adaptiveIphone5Frame.size.width+10, _leftL.adaptiveIphone5Frame.origin.y, back.adaptiveIphone5Frame.size.width-self.inputField.adaptiveIphone5Frame.origin.x-self.inputField.adaptiveIphone5Frame.size.width-30-10, 15)];
        rightL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        rightL.text = @"美元";
        rightL.textAlignment = NSTextAlignmentRight;
        rightL.font = [UIFont fontWithAdaptiveIphone5Size:15];
        [back addSubview:rightL];
    }
    return self;
}

-(void)textField1TextChange:(UITextField *)textField{
    [self.delegate ShowTwoTextChanged:self.inputField.text];
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
}

+(CGFloat)getCellHeight{
    return [UIView countBeforeWithIphone5Length:50];
}

-(void)reloadView:(NSArray *)arr{
    self.leftL.text = arr[0];
    self.inputField.placeholder = arr[1];
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

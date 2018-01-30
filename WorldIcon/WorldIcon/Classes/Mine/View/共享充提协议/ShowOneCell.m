//
//  ShowOneCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "ShowOneCell.h"
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
#define KMaxLength     100
@interface ShowOneCell()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *leftL;
@property(nonatomic,strong)UITextField *inputField;
@end
@implementation ShowOneCell

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
        self.leftL.text = @"充值金额";
        CGSize s = [tool characterAdaption:self.leftL.text withFont:[UIFont fontWithAdaptiveIphone5Size:15]];
        self.leftL.adaptiveIphone5Frame = CGRectMake(20, 17.5f, [UIView countIphone5LengthWithBeforeLength:s.width], 15);
        self.leftL.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.leftL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [back addSubview:self.leftL];
        
        _inputField = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.leftL.adaptiveIphone5Frame.origin.x+self.leftL.adaptiveIphone5Frame.size.width+10,10, back.adaptiveIphone5Frame.size.width-self.leftL.adaptiveIphone5Frame.origin.x-self.leftL.adaptiveIphone5Frame.size.width-10-30, 30)];
        _inputField.backgroundColor = [UIColor gc_colorWithHexString:@"#e6e8f3"];
        _inputField.userInteractionEnabled = NO;
        _inputField.layer.cornerRadius = [UIView countBeforeWithIphone5Length:30]/2.0f;
        
        UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        imageView.adaptiveIphone5Frame = CGRectMake(0, 0, 30, 15);
        [imageView setImage:[UIImage imageNamed:@"xiajian"] forState:UIControlStateNormal];
//        [imageView addTarget:self action:@selector(imageViewAction) forControlEvents:UIControlEventTouchUpInside];
        _inputField.rightView = imageView;
        _inputField.rightViewMode = UITextFieldViewModeAlways;
        
        UILabel *View = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 15)];
        _inputField.leftView = View;
        _inputField.leftViewMode = UITextFieldViewModeAlways;
        
        _inputField.placeholder = @"";
        _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputField.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _inputField.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.inputField.delegate = self;
        [back addSubview:_inputField];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate textChanged:self.inputField.text];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextPosition* beginning = textField.beginningOfDocument;
    UITextRange* markedTextRange = textField.markedTextRange;
    UITextPosition* selectionStart = markedTextRange.start;
    UITextPosition* selectionEnd = markedTextRange.end;
    NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange tRange = NSMakeRange(location,length);
    NSString *newString = [textField.text substringWithRange:tRange];
    NSString *oldString = [textField.text stringByReplacingOccurrencesOfString:newString withString:@"" options:0 range:tRange];
    if(newString.length <= 0)//非汉字输入
    {
        if (textField.text.length > self.maxNum) {
            textField.text = self.inputOldStr;
            [self showHUDTopic];
        }else{
            self.inputOldStr = textField.text;
        }
    }else//汉字输入
    {
        NSInteger tNewNumber = newString.length;
        NSInteger tOldNumber = oldString.length;
        BOOL isEnsure = (newString.length*2 == tNewNumber);//判断markedText是汉字还是字母。如果是汉字，说是用户最终输入。
        if(isEnsure && tNewNumber+tOldNumber > self.maxNum)
        {
            NSInteger tIndex = (tNewNumber+tOldNumber) - self.maxNum;
            tIndex = tNewNumber - tIndex;
            tIndex /= 2;
            NSString *finalStr = [oldString substringToIndex:location];
            finalStr = [finalStr stringByAppendingString:[newString substringToIndex:tIndex]];
            finalStr = [finalStr stringByAppendingString:[oldString substringFromIndex:location]];
            textField.text = finalStr;
            [self showHUDTopic];
        }
    }
}

+(CGFloat)getCellHeight{
    return [UIView countBeforeWithIphone5Length:50];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    HIDE_KEYBOARD;
    return YES;
}

- (void)setMaxNumber:(float)maxNum
{
    self.maxNum = maxNum;
}

-(void)showHUDTopic{

}

-(void)showHUDTopic:(NSString *)topicCode{
}

-(void)reloadView:(NSArray *)arr{
    self.leftL.text = arr[0];
    self.inputField.placeholder = arr[1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



- (void)awakeFromNib {
    [super awakeFromNib];
}


@end

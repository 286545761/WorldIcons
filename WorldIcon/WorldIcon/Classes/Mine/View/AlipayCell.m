//
//  AlipayCell.m
//  bage
//
//  Created by 郭飞燕 on 2017/12/6.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "AlipayCell.h"
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
#define KMaxLength     100
@interface AlipayCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *leftL;
@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UILabel *leftL2;
@property (nonatomic, strong) UITextField *inputField2;
@end
@implementation AlipayCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor gc_colorWithHexString:@"#f0f4f7"];
        self.backgroundColor = [UIColor gc_colorWithHexString:@"#f0f4f7"];
        UIView *back = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(10, 10, 320-20, 80)];
        back.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:back];
        
        self.leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 25.0/2, 100, 15)];
        self.leftL.text = @"支付宝账号";
        self.leftL.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.leftL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [back addSubview:self.leftL];
        
        _inputField = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.leftL.adaptiveIphone5Frame.origin.x+self.leftL.adaptiveIphone5Frame.size.width+10, self.leftL.adaptiveIphone5Frame.origin.y, back.adaptiveIphone5Frame.size.width-self.leftL.adaptiveIphone5Frame.origin.x-self.leftL.adaptiveIphone5Frame.size.width-10-10, 15)];
        _inputField.placeholder = @"请输入支付宝账号";
        _inputField.tag = 100;
        _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputField.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _inputField.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.inputField.delegate = self;
        [back addSubview:_inputField];
        
        UIView *line1 = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 40, 320-20-20, 1)];
        line1.backgroundColor = RGBA(245, 245, 245,1);
        [back addSubview:line1];
        
        _leftL2 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10,line1.adaptiveIphone5Frame.origin.y+line1.adaptiveIphone5Frame.size.height+25.0/2, 100, 15)];
        _leftL2.text = @"支付宝真实姓名";
        _leftL2.tag = 102;
        _leftL2.font = [UIFont fontWithAdaptiveIphone5Size:15];
        _leftL2.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [back addSubview:_leftL2];
        
        _inputField2 = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(_leftL2.adaptiveIphone5Frame.origin.x+_leftL2.adaptiveIphone5Frame.size.width+10, line1.adaptiveIphone5Frame.origin.y+line1.adaptiveIphone5Frame.size.height+25.0/2, back.adaptiveIphone5Frame.size.width-self.leftL.adaptiveIphone5Frame.origin.x-self.leftL.adaptiveIphone5Frame.size.width-10-10, 15)];
        _inputField2.placeholder = @"请输入支付宝真实姓名";
        _inputField2.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputField2.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _inputField2.font = [UIFont fontWithAdaptiveIphone5Size:15];
        _inputField2.tag = 101;
        _inputField2.delegate = self;
        [back addSubview:_inputField2];
    }
    return self;
}

-(void)reloadView:(NSArray *)arr{
    self.leftL.text = arr[0];
    self.inputField.placeholder = arr[1];
    self.leftL2.text = arr[2];
    self.inputField2.placeholder = arr[3];
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField *t1 = [self.contentView viewWithTag:100];
    UITextField *t2 = [self.contentView viewWithTag:101];
    NSString *str1 = t1.text;
    NSString *str2 = t2.text;
    if ([self.leftL.text isEqualToString:@"微信号"]) {
        [self.delegate textChanged:str1 andText:str2 tag:@"1"];
    }else{
        [self.delegate textChanged:str1 andText:str2 tag:nil];
    }
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
    //    if (self.maxNum == KTitleMaxNumber) {
    //        [self showHUDTopic:@"mycard_601_001"];
    //    }
    //    else if (self.maxNum == KSubtitleMaxNumber){
    //        [self showHUDTopic:@"mycard_601_002"];
    //    }
}

-(void)showHUDTopic:(NSString *)topicCode{
    //    [SVStatusHUD showWithImage:nil status:[[TNACompatible sharedTNACompatible] getDescriptionStringWithErrorCodeString:topicCode] duration:0.8];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end

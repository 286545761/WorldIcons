//
//  CardCell.m
//  bage
//
//  Created by 郭飞燕 on 2017/12/5.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CardCell.h"
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
#define KMaxLength     100
@interface CardCell()

@property (nonatomic, strong) UILabel *leftL;
@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UITextField *inputField2;
@property (nonatomic, strong) UILabel *showProvince;
@property (nonatomic, strong) UILabel *showaccount;
@property (nonatomic, strong) UIButton *accountBtn;
@property (nonatomic, strong) UIButton *provinceBtn;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UIView *back;
@end;
@implementation CardCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor gc_colorWithHexString:@"#f0f4f7"];
        self.backgroundColor = [UIColor gc_colorWithHexString:@"#f0f4f7"];
        _back = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(10, 10, 320-20, 160)];
        _back.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_back];
        
        self.leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 25.0/2, 50, 15)];
        self.leftL.text = @"持卡人";
        self.leftL.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.leftL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [_back addSubview:self.leftL];
        
        _inputField = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.leftL.adaptiveIphone5Frame.origin.x+self.leftL.adaptiveIphone5Frame.size.width+10, self.leftL.adaptiveIphone5Frame.origin.y, _back.adaptiveIphone5Frame.size.width-self.leftL.adaptiveIphone5Frame.origin.x-self.leftL.adaptiveIphone5Frame.size.width-10-10, 15)];
        _inputField.placeholder = @"请输入持卡人";
        _inputField.tag = 100;
        _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputField.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _inputField.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.inputField.delegate = self;
        [_back addSubview:_inputField];
        
        UIView *line1 = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 40, 320-20-20, 1)];
        line1.backgroundColor = RGBA(245, 245, 245,1);
        [_back addSubview:line1];
        
        UILabel *leftL2 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10,line1.adaptiveIphone5Frame.origin.y+line1.adaptiveIphone5Frame.size.height+25.0/2, 50, 15)];
        leftL2.text = @"卡号";
        leftL2.font = [UIFont fontWithAdaptiveIphone5Size:15];
        leftL2.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        [_back addSubview:leftL2];
        
        UITextField *inputField2 = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(leftL2.adaptiveIphone5Frame.origin.x+leftL2.adaptiveIphone5Frame.size.width+10, line1.adaptiveIphone5Frame.origin.y+line1.adaptiveIphone5Frame.size.height+25.0/2, _back.adaptiveIphone5Frame.size.width-self.leftL.adaptiveIphone5Frame.origin.x-self.leftL.adaptiveIphone5Frame.size.width-10-10, 15)];
        inputField2.placeholder = @"请输入卡号";
        inputField2.tag = 101;
        inputField2.clearButtonMode = UITextFieldViewModeWhileEditing;
        inputField2.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        inputField2.font = [UIFont fontWithAdaptiveIphone5Size:15];
        inputField2.delegate = self;
        [_back addSubview:inputField2];
        
        UIView *line2 = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, line1.adaptiveIphone5Frame.origin.y+40, 320-20-20, 1)];
        line2.backgroundColor = RGBA(245, 245, 245,1);
        [_back addSubview:line2];
        
        
        _accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _accountBtn.adaptiveIphone5Frame = CGRectMake(10, line2.adaptiveIphone5Frame.origin.y+line2.adaptiveIphone5Frame.size.height, line1.adaptiveIphone5Frame.size.width, 39);
        [_accountBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchDown];
        [_accountBtn setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _accountBtn.titleLabel.adaptiveIphone5Frame = CGRectMake(0, 0, 200, 39);
        _accountBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:15];
        [_accountBtn setTitle:@"开户行" forState:UIControlStateNormal];
        _accountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [accountBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        self.inputField2 = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, _accountBtn.adaptiveIphone5Frame.origin.y+_accountBtn.adaptiveIphone5Frame.size.height+5,0, 0)];
        self.inputField2.placeholder = @"请输入开户行";
        self.inputField2.tag = 105;
        self.inputField2.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.inputField2.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        self.inputField2.font = [UIFont fontWithAdaptiveIphone5Size:15];
        self.inputField2.delegate = self;
        self.inputField2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.inputField2];
        
        UIImageView *accountBtnIG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头-拷贝-2"]];
        accountBtnIG.adaptiveIphone5Frame = CGRectMake(_accountBtn.adaptiveIphone5Frame.size.width-8, 15, 8, 10);
        [_accountBtn addSubview:accountBtnIG];
        [_back addSubview:_accountBtn];
        CGSize si = [CardCell characterAdaption:@"开户行" withFont:[UIFont fontWithAdaptiveIphone5Size:15]];
        _showaccount = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(si.width, 25.0/2, _accountBtn.adaptiveIphone5Frame.size.width-8-8-5-si.width, 15)];
        _showaccount.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _showaccount.font = [UIFont fontWithAdaptiveIphone5Size:15];
        _showaccount.textAlignment = NSTextAlignmentRight;
        [_accountBtn addSubview:_showaccount];
        
        UIView *line3 = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, line2.adaptiveIphone5Frame.origin.y+39, 320-20-20, 1)];
        line3.backgroundColor = RGBA(245, 245, 245,1);
        [_back addSubview:line3];
        
        
        _line4 = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, self.inputField2.adaptiveIphone5Frame.origin.y+self.inputField2.adaptiveIphone5Frame.size.height, 320-20-20, 1)];
        _line4.backgroundColor = RGBA(245, 245, 245,1);
        [_back addSubview:_line4];
        
        _provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_provinceBtn setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _provinceBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:15];
        _provinceBtn.adaptiveIphone5Frame = CGRectMake(10, _line4.adaptiveIphone5Frame.origin.y+_line4.adaptiveIphone5Frame.size.height, line1.adaptiveIphone5Frame.size.width, 40);
        [_provinceBtn addTarget:self action:@selector(provinceBtnAction:) forControlEvents:UIControlEventTouchDown];
        [_provinceBtn setTitle:@"所在省市" forState:UIControlStateNormal];
        _provinceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [provinceBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        UIImageView *provinceBtnIG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头-拷贝-2"]];
        provinceBtnIG.adaptiveIphone5Frame = CGRectMake(_provinceBtn.adaptiveIphone5Frame.size.width-8, 15, 8, 10);
        [_provinceBtn addSubview:provinceBtnIG];
        [_back addSubview:_provinceBtn];
        CGSize s = [CardCell characterAdaption:@"所在省市" withFont:[UIFont fontWithAdaptiveIphone5Size:15]];
        _showProvince = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(s.width, 25.0/2, _provinceBtn.adaptiveIphone5Frame.size.width-8-8-5-s.width, 15)];
        _showProvince.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        _showProvince.font = [UIFont fontWithAdaptiveIphone5Size:15];
        _showProvince.textAlignment = NSTextAlignmentRight;
        [_provinceBtn addSubview:_showProvince];
    }
    return self;
}

-(void)reloadCell:(NSArray *)arr
           isshow:(BOOL)show{
    
    NSDictionary * accountNumber = [arr objectAtIndex:2];
    NSDictionary * provinceName = [arr objectAtIndex:3];
    
    _showaccount.text = accountNumber[@"content"];
    _showProvince.text = provinceName[@"content"];
    if (show == YES) {
        _back.adaptiveIphone5Frame = CGRectMake(10, 10, 320-20, 160+40);
        self.inputField2.adaptiveIphone5Frame = CGRectMake(20, _accountBtn.adaptiveIphone5Frame.origin.y+_accountBtn.adaptiveIphone5Frame.size.height+20,280, 19);
    }else{
        _back.adaptiveIphone5Frame = CGRectMake(10, 10, 320-20, 160);
        self.inputField2.adaptiveIphone5Frame = CGRectMake(0, _accountBtn.adaptiveIphone5Frame.origin.y+_accountBtn.adaptiveIphone5Frame.size.height,0, 0);
    }
    _line4.adaptiveIphone5Frame = CGRectMake(10, self.inputField2.adaptiveIphone5Frame.origin.y+self.inputField2.adaptiveIphone5Frame.size.height-1, 320-20-20, 1);
    _provinceBtn.adaptiveIphone5Frame = CGRectMake(10, _line4.adaptiveIphone5Frame.origin.y+_line4.adaptiveIphone5Frame.size.height, _line4.adaptiveIphone5Frame.size.width, 40);
    
}

-(void)accountBtnAction:(UIButton *)sender{
    if (self.accountBtnBlock) {
        self.accountBtnBlock(sender.titleLabel.text);
    }
}

-(void)provinceBtnAction:(UIButton *)sender{
    if (self.provinceBtnBlock) {
        self.provinceBtnBlock(sender.titleLabel.text);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    UITextField *t1 = [self.contentView viewWithTag:100];
    UITextField *t2 = [self.contentView viewWithTag:101];
    NSString *str1 = t1.text;
    NSString *str2 = t2.text;
    [self.delegate textChanged:str1 Text:str2 other:self.inputField2.text];
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

#pragma mark - 文字自适应宽度
+(CGSize)characterAdaption:(NSString *)Str
                  withFont:(UIFont *)font{
    return [Str sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end

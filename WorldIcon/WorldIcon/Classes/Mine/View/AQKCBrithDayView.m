//
//  AQKCBrithDayView.m
//  safeCar
//
//  Created by 郭飞燕 on 17/4/18.
//  Copyright © 2017年 郭飞燕. All rights reserved.
//

#import "AQKCBrithDayView.h"
@interface AQKCBrithDayView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIDatePicker *datePicker;
@end

@implementation AQKCBrithDayView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.4f);
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 250)];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.layer.masksToBounds = YES;
        self.backView.layer.cornerRadius = 4;
//        [UIView countBeforeWithIphone5Length:4];
        [self addSubview:_backView];
        //创建一个UIPickView对象
         _datePicker = [[UIDatePicker alloc]init];
        //自定义位置
        _datePicker.frame = CGRectMake(0, 40, kScreenWidth, 210);
        //设置背景颜色
//        _datePicker.backgroundColor = [UIColor clearColor];
        //datePicker.center = self.center;
        //设置本地化支持的语言（在此是中文)
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //显示方式是只显示年月日
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSString *dateStr =@"1980-01-01 00:11:59";
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        _datePicker.date = date;
        NSString *currentDate = @"2016-12-31 00:11:59";
        NSDate *cu = [dateFormat dateFromString:currentDate];
        _datePicker.maximumDate = cu;
        //放在盖板上
        [self.backView addSubview:_datePicker];
        
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor gc_colorWithHexString:@"#ef3b3c"] forState:UIControlStateNormal];
        cancleBtn.frame = CGRectMake(0, 0, 60, 40);
        cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchDown];
        [self.backView addSubview:cancleBtn];
        
        UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [ensureBtn setTitleColor:[UIColor gc_colorWithHexString:@"#ef3b3c"] forState:UIControlStateNormal];
        ensureBtn.frame = CGRectMake(kScreenWidth-60, 0, 60, 40);
        ensureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [ensureBtn addTarget:self action:@selector(ensureBtnAction) forControlEvents:UIControlEventTouchDown];
        [self.backView addSubview:ensureBtn];
        
        UITapGestureRecognizer* singleRecognizer;
        
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signalTap)];
        
        singleRecognizer.delegate=self;
        
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        
        [self addGestureRecognizer:singleRecognizer];
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
        lineview.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
        [self.backView addSubview:lineview];
    }
    return self;
}

-(void)ensureBtnAction
{
    NSDate *theDate = _datePicker.date;//该属性返回选中的时间
    NSLog(@"%@",theDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//返回一个日期格式对象
    dateFormatter.dateFormat = @"YYYY-MM-dd";//该属性用于设置日期格式为YYYY-MM-dd HH-mm-ss
    if ([self.delegate respondsToSelector:@selector(ensureBtnOnClick:)]) {
        [self.delegate ensureBtnOnClick:[dateFormatter stringFromDate:theDate]];
    }
}

-(void)cancleBtnAction
{
    if ([self.delegate respondsToSelector:@selector(cancelBtnOnClick)]) {
        [self.delegate cancelBtnOnClick];
    }
}

- (void)signalTap
{
    [self cancleBtnAction];
}

@end

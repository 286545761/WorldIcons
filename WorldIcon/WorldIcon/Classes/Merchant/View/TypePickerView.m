//
//  TypePickerView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "TypePickerView.h"

@interface TypePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *_wholeView;
    UIView *_topView;
    NSString *_typeStr;
}
@property (nonatomic,strong)UIPickerView * pickerView;//自定义pickerview
@end

@implementation TypePickerView

+ (id)shareInstance
{
    static TypePickerView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[TypePickerView alloc] init];
    });
    
    return shareInstance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBottomView)];
        [self addGestureRecognizer:tap];
        
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    
    // 弹出的整个视图
    _wholeView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 250)];
    _wholeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_wholeView];
    
    // 头部按钮视图
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _topView.backgroundColor = [UIColor gc_colorWithHexString:@"#575757"];
    [_wholeView addSubview:_topView];
    
    // 防止点击事件触发
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [_topView addGestureRecognizer:topTap];
    
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(i*(kScreenWidth-50), 0, 50, 40);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [_topView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 240-40)];
    [_wholeView addSubview:self.pickerView];
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
}
- (void)buttonEvent:(UIButton *)button
{
    // 点击确定回调block
    if (button.tag == 1)
    {
        if (_block) {
            _block(_typeStr);
        }
    }
    
    [self hiddenBottomView];
}
- (void)showBottomView
{
    [UIView animateWithDuration:0.3 animations:^
     {
         _wholeView.frame = CGRectMake(0, kScreenHeight-250, kScreenWidth, 250);
         
     } completion:^(BOOL finished) {}];
    
    [self pickerView:_pickerView didSelectRow:3 inComponent:0];
    
}
- (void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^
     {
         _wholeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 250);
         
     } completion:^(BOOL finished) {
         [self removeFromSuperview];
     }];
}


#pragma mark UIPickerView DataSource Method 数据源方法
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;//第一个展示字母、第二个展示数字
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.types.count;
            //根据数组的元素个数返回几行数据
            break;
            
        default: break;
    }
    return result;
}
#pragma mark UIPickerView Delegate Method 代理方法
//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.types[row];
            break;
            
        default:
            break;
    }
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [pickerView selectRow:row inComponent:component animated:YES];
    
    _typeStr = _types[row];
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}
@end


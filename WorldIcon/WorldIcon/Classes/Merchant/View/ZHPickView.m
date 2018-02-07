//
//  ZHPickView.m
//  ZHpickView
//
//  Created by liudianling on 14-11-18.
//  Copyright (c) 2014年 赵恒志. All rights reserved.
//
#define ZHToobarHeight 40
#import "ZHPickView.h"

@interface ZHPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView        *_topView;
    UIView        *_mainView;
}
@property(nonatomic,copy)NSString *plistName;
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,assign)BOOL isLevelString;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,assign)NSDate *defaulDate;
@property(nonatomic,copy)NSString *resultString;
@property(nonatomic,strong)NSMutableArray *componentArray;
@property(nonatomic,strong)NSMutableArray *dicKeyArray;
@property(nonatomic,copy)NSMutableArray *state;

@end

@implementation ZHPickView

-(NSArray *)plistArray{
    if (_plistArray==nil) {
        _plistArray=[[NSArray alloc] init];
    }
    return _plistArray;
}

- (instancetype)initWithArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [self addGestureRecognizer:tap];
        
        NSString *path= [[NSBundle mainBundle] pathForResource:@"BankList" ofType:@"plist"];
        if (dataArray.count > 0) {
            _plistArray =[NSArray arrayWithArray:dataArray];
        }else
            _plistArray =[[NSArray alloc] initWithContentsOfFile:path];
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI{
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, GCHeight, GCWidth, 250)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.masksToBounds = YES;
    mainView.layer.cornerRadius = 4;
    [self addSubview:mainView];
    _mainView = mainView;
    
    // 头部按钮视图
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GCWidth, ZHToobarHeight)];
    //    _topView.backgroundColor = GCGlobalRed(1);
    [_mainView addSubview:_topView];
    
    // 防止点击事件触发
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [_topView addGestureRecognizer:topTap];
    
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(GCWidth-50), 0, 50, ZHToobarHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor gc_colorWithHexString:@"#ef3b3c"] forState:UIControlStateNormal];
        [_topView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //添加pickerView
    UIPickerView *pickView=[[UIPickerView alloc] init];
    pickView.frame=CGRectMake(0, ZHToobarHeight, GCWidth, 210);
    pickView.delegate=self;
    pickView.dataSource=self;
    if (_plistArray.count > 5) {
        _resultString = _plistArray[3];
        [pickView selectRow:3 inComponent:0 animated:YES];
    }else
        if (_plistArray.count >= 1) {
            _resultString = _plistArray[0];
            [pickView selectRow:0 inComponent:0 animated:YES];
        }
    
    [_mainView addSubview:pickView];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, GCWidth, 0.5)];
    lineview.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [_mainView addSubview:lineview];
}

- (void)buttonEvent:(UIButton *)button
{
    
    
    if (button.tag == 1) {
        if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:)]) {
            [self.delegate toobarDonBtnHaveClick:self resultString:_resultString];
        }
        
        
        
        
    }else{
    }
    [self removeView];
}


#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _plistArray.count;
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _plistArray[row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _resultString=_plistArray[row];
}

- (void)showView
{
    
    [UIView animateWithDuration:0.3 animations:^
     {
         _mainView.frame = CGRectMake(0, GCHeight-250-50, GCWidth, 250);
         
     } completion:^(BOOL finished) {}];
    
}

- (void)removeView
{
    [UIView animateWithDuration:0.3 animations:^
     {
         _mainView.frame = CGRectMake(0, GCHeight, GCWidth, 250);
         
     } completion:^(BOOL finished) {
         [self removeFromSuperview];
     }];
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *pickerLabel = (UILabel *)view;
//    if (!pickerLabel)
//    {
//        pickerLabel = [[UILabel alloc] init];
//        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
//        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
//    }
//    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//
//    return pickerLabel;
//}
@end

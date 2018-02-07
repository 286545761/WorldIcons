//
//  KLineTableViewCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/7.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "KLineTableViewCell.h"
#import "TLineChartView.h"
#import "KLineListManager.h"
#import "KLineListTransformer.h"
#import "StatusView.h"
@interface KLineTableViewCell()<GAPIBaseManagerRequestCallBackDelegate>
@property (nonatomic, strong)TLineChartView *tLineChartView;
@property (nonatomic, strong) KLineListManager *chartApi;
@property (nonatomic, strong) KLineListTransformer *lineListTransformer;
@property (nonatomic, strong) StatusView *kStatusView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation KLineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpView{
    UILabel *showL = [[UILabel alloc]initWithFrame:CGRectMake(0, 200/2.0f-10, kScreenWidth, 20)];
    showL.text = @"没有数据展示";
    showL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    showL.textAlignment = NSTextAlignmentCenter;
    showL.textColor = [UIColor gc_colorWithHexString:@"#b64800"];
    [self.contentView addSubview:showL];
    [self.contentView addSubview:self.tLineChartView];
}

-(void)reloadCell:(NSArray *)arr{
    if (arr.count == 0) {
        self.tLineChartView.hidden = YES;
    }else{
        self.tLineChartView.hidden = NO;
        [self drawChart:arr];
    }
}

#pragma mark - GAPIBaseManagerRequestCallBackDelegate

- (void)managerApiCallBackDidSuccess:(__kindof GApiBaseManager *)manager {
    self.data = [[self.chartApi fetchDataWithTransformer:self.lineListTransformer] mutableCopy];
    [self.tLineChartView drawChartWithData:self.data];
    
    self.kStatusView.status = StatusStyleSuccess;
    self.kStatusView.hidden = YES;
    
    //动态数据测试
    //[self startTimer];
}

- (void)managerApiCallBackDidFailed:(__kindof GApiBaseManager *)manager {
    self.kStatusView.hidden = NO;
    switch (manager.requestHandleType) {
        case GAPIManagerRequestHandlerTypeDefault:
        case GAPIManagerRequestHandlerTypeFailure:
        case GAPIManagerRequestHandlerTypeParamsError:
        case GAPIManagerRequestHandlerTypeNoContent:
        case GAPIManagerRequestHandlerTypeTimeout: {
            self.kStatusView.status = StatusStyleFailed;
            break;
        }
        case GAPIManagerRequestHandlerTypeNoNetWork: {
            self.kStatusView.status = StatusStyleNoNetWork;
            break;
        }
        default:break;
    }
}


- (void)drawChart:(NSArray *)arr {
    NSArray *array = [self.lineListTransformer manager:nil transformData:arr];
    self.data = array;
    [self.tLineChartView drawChartWithData:array];
}

- (TLineChartView *)tLineChartView {
    if (!_tLineChartView) {
        _tLineChartView = [[TLineChartView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 180.0f)];
        _tLineChartView.backgroundColor = [UIColor whiteColor];
        _tLineChartView.topMargin = 5.0f;
        _tLineChartView.leftMargin = 1;
        _tLineChartView.bottomMargin = 0.5;
        _tLineChartView.rightMargin = 1.0;
        _tLineChartView.pointPadding = 0;
        _tLineChartView.separatorNum = 4;
        _tLineChartView.lineColor = RGBA(68, 138, 202, 1);
        _tLineChartView.separatorColor = RGBA(200, 200, 200, 1);
        _tLineChartView.axisShadowColor = RGBA(200, 200, 200, 1);
        _tLineChartView.crossLineColor = RGBA(200, 200, 200, 1);
        _tLineChartView.flashPoint = NO;
        //_tLineChartView.smoothPath = NO;
        _tLineChartView.gradientStartColor = [UIColor clearColor];
        _tLineChartView.gradientEndColor = [UIColor clearColor];
        _tLineChartView.yAxisTitleColor = [UIColor clearColor];
        _tLineChartView.xAxisTitleColor = [UIColor clearColor];
//        _tLineChartView.timeTipTextColor = [UIColor gc_colorWithHexString:@"#c96705"];
        _tLineChartView.timeTipBackgroundColor = [UIColor gc_colorWithHexString:@"#b64800"];
        _tLineChartView.axisShadowWidth = 0;
    }
    return _tLineChartView;
}

- (StatusView *)kStatusView {
    if (!_kStatusView) {
        _kStatusView = [[StatusView alloc] initWithFrame:_tLineChartView.bounds];
    }
    return _kStatusView;
}

- (KLineListManager *)chartApi {
    if (!_chartApi) {
        _chartApi = [KLineListManager new];
        _chartApi.delegate = self;
    }
    return _chartApi;
}

- (KLineListTransformer *)lineListTransformer {
    if (!_lineListTransformer) {
        _lineListTransformer = [KLineListTransformer new];
    }
    return _lineListTransformer;
}

+(CGFloat)getHeight{
    return 200;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

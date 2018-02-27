//
//  TheMillDetailsView.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/8.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "TheMillDetailsView.h"
#import "AppDelegate.h"
#import "MachinesModel.h"
@interface TheMillDetailsView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)MachineModel *mmodel;
@property(nonatomic,strong)MachinesModel *shopingmodel;
@property(nonatomic,strong)UIView *coverView;

@end
static NSString *titcell=@"TheMillDetailsViewCell";
@implementation TheMillDetailsView
//-(NSMutableArray *)dataSourceArray{
//    if (!_dataSourceArray) {
//        _dataSourceArray =[[NSMutableArray alloc]init];
//    }
//    return _dataSourceArray;
//}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        UILabel *headLabel =[UILabel gc_labelWithTitle:@"详情" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:17 withTextAlignment:NSTextAlignmentCenter];
        headLabel.frame=CGRectMake(0, 0, 300, 40);
        self.tableView.tableHeaderView=headLabel;
        UIButton *footButton =[[UIButton alloc]init];
        [footButton setTitle:@"关闭" forState:UIControlStateNormal];
        [footButton setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        footButton.frame=CGRectMake(0, 0, 300, 40);
        [footButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableFooterView=footButton;
        
        
    }
    
    return self;
}
-(void)closeView{
    
    
    [self.coverView removeFromSuperview];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(20, 100, GCWidth-40 , GCHeight-200) style:UITableViewStylePlain];
        
        _tableView.backgroundColor= [UIColor whiteColor];
        _tableView.layer.cornerRadius=20.f;
        _tableView.layer.masksToBounds=YES;
        _tableView.delegate=self;
        _tableView.dataSource=self;
_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:titcell];
//        _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        [self.coverView addSubview:_tableView];
     
        
        
    }
    
    return _tableView;
}
-(UIView *)coverView{
    if (!_coverView) {
        _coverView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, GCWidth, GCHeight)];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 1.f;
        _coverView.userInteractionEnabled=YES;
        
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddeCoverView)];
//        [ _coverView addGestureRecognizer:tap];
        
    }
    
    return _coverView;
}
-(void)showViewWithDataSource:(MachineModel*)dataSoure{
    AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *superview = appd.window;
    [superview addSubview:self.coverView];
    self.mmodel=dataSoure;
    [self.tableView reloadData];
    
}
-(void)shopingShowViewWithDataSource:(MachinesModel*)shopingdataSoure{
    AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *superview = appd.window;
    [superview addSubview:self.coverView];
    self.shopingmodel=shopingdataSoure;
    [self.tableView reloadData];
    
    
    
}
-(void)setTypeString:(NSString *)typeString{
    _typeString=typeString;
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:titcell];
 cell.textLabel.numberOfLines=0;
//    cell.separatorInset = UIEdgeInsetsMake(0, GCWidth, 0, 0); //
    cell.textLabel.textColor=[UIColor gc_colorWithHexString:@"#999999"];

            if ([self.typeString isEqualToString:@"0"]) {
                if (indexPath.row==0) {
      
                    cell.textLabel.text=[NSString stringWithFormat:@"矿机名称：%@",self.shopingmodel.cm_name];
                    
                } else if (indexPath.row==1){
                  
                    cell.textLabel.text=[NSString stringWithFormat:@"矿机介绍：%@",  self.shopingmodel.cm_info];
                   
              
                    
                }else if (indexPath.row==2){
                    cell.textLabel.text=[NSString stringWithFormat:@"矿机价格：%@",self.shopingmodel.cm_value];
                  
                  
   

                    
                }else if (indexPath.row==3){
                      cell.textLabel.text=[NSString stringWithFormat:@"可挖金矿数量：%@",self.shopingmodel.cm_jk];
                    
                }else if (indexPath.row==4){
                    
                      cell.textLabel.text=[NSString stringWithFormat:@"可挖银矿数量：%@",self.shopingmodel.cm_yk];
                }else if (indexPath.row==5){
                    cell.textLabel.text=[NSString stringWithFormat:@"可挖铜矿数量：%@",self.shopingmodel.cm_tk];
                  
                    
                }else if (indexPath.row==6){
                    NSString *staua;
                    if ([self.shopingmodel.cm_status isEqualToString:@"0"]) {
                         staua=@"不对外销售";
                    } else if([self.shopingmodel.cm_status isEqualToString:@"1"]){
                                     staua=@"正常销售";
                    }else if([self.shopingmodel.cm_status isEqualToString:@"1"]){
                        staua=@"冻结";
                    }
                        
                      cell.textLabel.text=[NSString stringWithFormat:@"状态：%@",staua];
                    
                }
                
                
                
                
            } else {
                switch (indexPath.row) {
            
                
            case 0:
                
                cell.textLabel.text=[NSString stringWithFormat:@"矿机名称：%@",self.mmodel.mm_cm_name];
                break;
            case 1:
                
                cell.textLabel.text=[NSString stringWithFormat:@"矿机介绍：%@",self.mmodel.mm_cm_info];
                break;
            case 2:
                
                cell.textLabel.text=[NSString stringWithFormat:@"矿机价格：%@",self.mmodel.mm_cm_value];
                break;
            case 3:
                
                cell.textLabel.text=[NSString stringWithFormat:@"可挖金矿数量：%@",self.mmodel.mm_cm_jk];
                
                break;
            case 4:
                cell.textLabel.text=[NSString stringWithFormat:@"可挖银矿数量：%@",self.mmodel.mm_cm_yk];
                break;
                
            case 5:
                cell.textLabel.text=[NSString stringWithFormat:@"可挖铜矿数量：%@",self.mmodel.mm_cm_tk];
                break;
            case 6:
                cell.textLabel.text=[NSString stringWithFormat:@"已挖金矿数量：%@",self.mmodel.mm_cm_jk1];
                break;
            case 7:
                cell.textLabel.text=[NSString stringWithFormat:@"已挖银矿数量：%@",self.mmodel.mm_cm_yk1];
                break;
            case 8:
                cell.textLabel.text=[NSString stringWithFormat:@"已挖铜矿数量：%@",self.mmodel.mm_cm_tk1];
                break;
            case 9:{
                NSString *pol;
                if ([self.mmodel.mm_status isEqualToString:@"0"]) {
                    pol=@"未开始";
                } else if ([self.mmodel.mm_status isEqualToString:@"1"]) {
                    pol=@"正在挖矿";
                }else{
                    pol=@"挖矿结束";
                }
                
                
                cell.textLabel.text=[NSString stringWithFormat:@"状态：%@",pol];
                break;
                
            }
            case 10:
                
                cell.textLabel.text=[NSString stringWithFormat:@"矿机结束时间：%@",self.mmodel.mm_end_time];
                break;
            case 11:
                cell.textLabel.text=[NSString stringWithFormat:@"购买时间：%@",self.mmodel.mm_date];
                break;
                
            default:
                break;
            
            }
            
    }
            
            return cell;
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.typeString isEqualToString:@"0"]) {
        return 7;
    }
    return 13;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        return 120;
    }
    return 40;
}


@end

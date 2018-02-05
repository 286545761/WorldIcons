//
//  newCurrentProgressAViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressAViewController.h"

#import "newCurrentProgressApplicantsTableViewCell.h"
#import "newCurrentProgressSharersTableViewCell.h"
#import "newCurrentProgressApplicantsTableViewCell.h"
#import "newCurrentProgressTableViewCell.h"
#import "newCurrentProgressMakeSureMoneyTableViewCell.h"


static NSString *SharersCell=@"newCurrentProgressSharersTableViewCell";
static NSString *ApplicantsSharersCell=@"newCurrentProgressApplicantsTableViewCell";
static NSString *ProgressCell=@"newCurrentProgressTableViewCell";
static NSString *MakeSureMoneyCell=@"newCurrentProgressMakeSureMoneyTableViewCell";
static NSString *fcell=@"fcell";
@interface newCurrentProgressAViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *senderMessageView;

@property(nonatomic,strong)UITextField *senderTextField;
@end

@implementation newCurrentProgressAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navLabel.text = @"充值进度";
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView=self.senderMessageView;
}
-(UIView *)senderMessageView{
    
    if (!_senderMessageView) {
       _senderMessageView =[[UIView alloc]initWithFrame:CGRectMake(10, 0,GCWidth-20 , 50)];
        _senderMessageView.backgroundColor =[UIColor whiteColor];
        
       self.senderTextField =[UITextField textFieldWithBackGroundColor:[UIColor whiteColor] withText:@"" withTextAlignment:NSTextAlignmentLeft withTextFont:15 withTextColor:[UIColor gc_colorWithHexString:@"#66666"] withPlaceholderString:@"请输入留言" withTextFieldDelegate:self withClearButtonMode:UITextFieldViewModeNever withSecurtTextEntry:NO withKeyboardTtype:UIKeyboardTypeDefault withReturnKeyType:  UIReturnKeyDefault withParentView:nil];
        self.senderTextField.layer.cornerRadius=10.f;
        self.senderTextField.layer.borderColor=[UIColor gc_colorWithHexString:@"#666666"].CGColor;
        self.senderTextField.layer.borderWidth=2.f;
        self.senderTextField.layer.masksToBounds=YES;
        [_senderMessageView addSubview:self.senderTextField];
        UIButton *sendButton=[[UIButton alloc]init];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [sendButton addTarget:sendButton action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        
        sendButton.frame=CGRectMake(GCWidth-60, 10, 50, 35);
        
        [_senderMessageView addSubview:sendButton];
    
    }
    
    return _senderMessageView;
}
-(void)sendMessage{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
       return 225;
    }
    if (indexPath.section==1) {
        return 125;
    }
    if (indexPath.section==2) {
        return 80;
    }
//    if (indexPath.section==3) {
        return 40;
//    }
  
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIView countBeforeWithIphone5Length:5];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        
//        rect.origin.x = 10;
//        rect.size.width -= 20;
//        rect.size.height -= 64;
//        rect.size.height -= 44;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.backgroundColor=RGBA(231, 234, 243, 1);
//        _tableView.layer.masksToBounds = YES;
//        _tableView.layer.cornerRadius = 5;
        //        _tableView.separatorInset = UIEdgeInsetsMake(0,[UIView countBeforeWithIphone5Length:10], 0, [UIView countBeforeWithIphone5Length:10]);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        [_tableView registerClass:[newCurrentProgressSharersTableViewCell class] forCellReuseIdentifier:SharersCell];
        [_tableView registerClass:[newCurrentProgressApplicantsTableViewCell class] forCellReuseIdentifier:ApplicantsSharersCell];
        [_tableView registerClass:[newCurrentProgressTableViewCell class] forCellReuseIdentifier:ProgressCell];
//              [_tableView registerClass:[newCurrentProgressMakeSureMoneyTableViewCell class] forCellReuseIdentifier:MakeSureMoneyCell];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:fcell];
  
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
            newCurrentProgressSharersTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SharersCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        
  newCurrentProgressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ProgressCell];
          cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {

         newCurrentProgressMakeSureMoneyTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:MakeSureMoneyCell];
        if (!hotCell)
        {
            hotCell = [[newCurrentProgressMakeSureMoneyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MakeSureMoneyCell];

        }
        hotCell.backgroundColor=[UIColor clearColor];
          hotCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return hotCell;
    }
//    if (indexPath.section==4) {
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:fcell];
//        if (!cell) {
//            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCel"];
    cell.backgroundColor =[UIColor whiteColor];
    cell.layer.cornerRadius=10.f;
    cell.layer.masksToBounds=YES;
            CGRect newFrame=cell.frame;
            newFrame.origin.y+=10;
            newFrame.origin.x+=10;
            newFrame.size.width-=20;
            cell.frame=newFrame;
            cell.textLabel.text=@"    留言";
            cell.textLabel.textColor=[UIColor blackColor];
        
//        }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
       

//    }
    
    
    return nil;

    
}

@end

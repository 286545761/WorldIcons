//
//  GXCTApplyTableViewCell.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/4.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "GXCTApplyTableViewCell.h"
#import "SharingApplicationModel.h"
@interface GXCTApplyTableViewCell()
@property(nonatomic,strong)UILabel *leftL;
@property(nonatomic,strong)UIButton *textBtn;
@property(nonatomic,strong)UIImageView *image;

@end
@implementation GXCTApplyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setIndex:(NSIndexPath *)index{
    
    _index=index;
}
-(void)setUpView{
    _leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(35, 25.0/2, 70,20)];
    _leftL.text = @"微信号";
    _leftL.textAlignment = NSTextAlignmentRight;
    _leftL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    _leftL.textAlignment = NSTextAlignmentRight;
    _leftL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    [self.contentView addSubview:_leftL];
    
    _textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _textBtn.adaptiveIphone5Frame = CGRectMake(_leftL.adaptiveIphone5Frame.origin.x+_leftL.adaptiveIphone5Frame.size.width+10, 5, 320-35-10-_leftL.adaptiveIphone5Frame.origin.x-_leftL.adaptiveIphone5Frame.size.width, 35);
    [_textBtn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [_textBtn setTitle:@"请选择微信号" forState:UIControlStateNormal];
    _textBtn.layer.masksToBounds = YES;
    _textBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:15];
    _textBtn.layer.cornerRadius = _textBtn.frame.size.height/2.0f;
    _textBtn.backgroundColor = RGBA(245, 245, 245, 1);
    [_textBtn addTarget:self action:@selector(textBtnAction) forControlEvents:UIControlEventTouchDown];
    _textBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _textBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.contentView addSubview:_textBtn];
    
    _image = [[UIImageView alloc
               ]initWithImage:[UIImage imageNamed:@"xiajian"]];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    _image.adaptiveIphone5Frame = CGRectMake(_textBtn.adaptiveIphone5Frame.size.width-10-12, 0, 12, _textBtn.adaptiveIphone5Frame.size.height);
    [_textBtn addSubview:_image];
}
-(void)setModel:(SharingApplicationModel *)model{
    self.leftL.text=model.titile;
    [self.textBtn setTitle:model.titledetails forState:UIControlStateNormal];
    
    
    
}
-(void)textBtnAction{
    if (self.selectBlock) {
        self.selectBlock(self.index);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

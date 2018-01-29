//
//  NumImageView.m
//  RongXin
//
//  Created by wdart on 13-12-18.
//  Copyright (c) 2013年 KSY. All rights reserved.
//

#import "NumImageView.h"

@implementation NumImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initViews];
}

- (void)initViews
{
    self.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:75.0f/255.0f blue:107.0f/255.0f alpha:1.000];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.viewSizeWith = self.bounds.size.width;
    self.numLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.numLabel.backgroundColor = [UIColor clearColor];
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:12];
    //self.numLabel.minimumFontSize = 8;
    self.numLabel.adjustsFontSizeToFitWidth = TRUE;
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.numLabel];
}

// 未读消息数显示修改
-(void)setNum:(NSString *)aNum
{
    NSInteger number = [aNum integerValue];
    if ([aNum integerValue] > 99) {
        // 显示 99+
        CGRect rect = self.frame;
        rect.size.width = self.viewSizeWith + 8;
        self.frame = rect;
        self.numLabel.text = @"99+";

    }
    else {
        if (number>9 ) {
            CGRect rect = self.frame;
            rect.size.width = self.viewSizeWith + 4;
            self.frame = rect;
            
        }
        
        self.numLabel.text = aNum;

    }
    self.numLabel.frame = self.bounds;

}


@end

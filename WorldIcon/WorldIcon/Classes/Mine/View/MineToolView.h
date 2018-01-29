//
//  MineToolView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineToolView;

@protocol MineToolViewDelegate <NSObject>

-(void)mineToolView:(MineToolView *)toolView didSelectedButton:(NSInteger)tag;

@end

@interface MineToolView : UIView

@property (nonatomic,assign)id<MineToolViewDelegate> delegate;

@end

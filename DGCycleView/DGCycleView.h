//
//  DGCycleView.h
//  CycleScrollView
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 issuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGCycleView;

@protocol DGCycleViewDelegate <NSObject>

-(void)cycleView:(DGCycleView *)cycleView clickIndex:(NSInteger)index;

@end

@interface DGCycleView : UIView


-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;


@end

//
//  SSWMutipleBarChartView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSWMutipleBarChartView : UIView

@property(nonatomic)NSMutableArray      *xValuesArr;
@property(nonatomic)NSMutableArray      *yValuesArr;
@property(nonatomic)NSMutableArray      *barColorArr;
@property(nonatomic,assign)CGFloat      barWidth;
@property(nonatomic,assign)CGFloat      gapWidth;
@property(nonatomic,assign)NSInteger    yAxiasCount;
@property(nonatomic,assign)NSInteger    yAxiasValus;
@property(nonatomic,copy)NSString       *unit;
@property(nonatomic)NSMutableArray      *legendTitlesArr;
@end

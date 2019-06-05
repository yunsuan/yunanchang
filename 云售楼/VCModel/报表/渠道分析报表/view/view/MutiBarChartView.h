//
//  MutiBarChartView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MutiBarChartView : UIView

@property(nonatomic)NSMutableArray      *xValuesArr;
@property(nonatomic)NSMutableArray      *yValuesArr;
@property(nonatomic)NSMutableArray      *barColorArr;
@property(nonatomic,assign)CGFloat      barWidth;
@property(nonatomic,assign)CGFloat      gapWidth;
@property(nonatomic,assign)NSInteger    yAxiasCount;
@property(nonatomic,assign)NSInteger    yAxiasValus;
@property(nonatomic,copy)NSString       *unit;
@property(nonatomic,assign)BOOL         showEachYValus;//是否显示每个Y值
@property(nonatomic)NSMutableArray      *legendTitlesArr;

- (void)setUp;
- (void)layoutSubviews;

@end

NS_ASSUME_NONNULL_END

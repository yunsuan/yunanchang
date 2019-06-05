//
//  SingleBarChartView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SingleBarChartView;

@protocol SingleBarChartViewDelegate <NSObject>

@optional

-(void)SingleBarChart:(SingleBarChartView *)chartView didSelectIndex:(NSInteger)index;

@end

@interface SingleBarChartView : UIView

@property(nonatomic)NSMutableArray      *xValuesArr;//x轴的值数组
@property(nonatomic)NSMutableArray      *yValuesArr;//y轴的值数组
@property(nonatomic,assign)CGFloat      barWidth;//柱形条的宽度
@property(nonatomic,assign)CGFloat      gapWidth;//间隔宽度
@property(nonatomic,assign)CGFloat      yScaleValue;//y轴的刻度值
@property(nonatomic,assign)int          yAxisCount;//y轴刻度的个数
@property(nonatomic,copy)NSString       *unit;//单位
@property(nonatomic)UIColor             *barCorlor;//设置柱形图的颜色

@property(nonatomic,assign)id<SingleBarChartViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END

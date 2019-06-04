//
//  SSWPieChartView.h
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018年 com.sswang.www. All rights reserved.
//

//#import "SSWCharts.h"
#import <UIKit/UIKit.h>

@interface SSWPieChartView : UIView

@property(nonatomic,strong)NSArray              *percentageArr;//百分比数组 对应piechart
@property(nonatomic)NSArray                     *colorsArr;//颜色组数 对应piechart
@property(nonatomic)NSArray                     *titlesArr;//标题数组 对应piechart

@property(nonatomic)UILabel                     *bubbleLab;//点击时提示泡泡
@property(nonatomic,assign)BOOL                 showEachYValus;//是否显示每个Y值

@property(nonatomic,assign)CGFloat      radius;//圆半径 默认为80
@end

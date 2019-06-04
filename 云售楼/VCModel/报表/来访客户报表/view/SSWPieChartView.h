//
//  SSWPieChartView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSWPieChartView : UIView

@property(nonatomic,strong)NSArray              *percentageArr;//百分比数组 对应piechart
@property(nonatomic)NSArray                     *colorsArr;//颜色组数 对应piechart
@property(nonatomic)NSArray                     *titlesArr;//标题数组 对应piechart

@property(nonatomic)UILabel                     *bubbleLab;//点击时提示泡泡
@property(nonatomic,assign)BOOL                 showEachYValus;//是否显示每个Y值

@property(nonatomic,assign)CGFloat      radius;//圆半径 默认为80
@end

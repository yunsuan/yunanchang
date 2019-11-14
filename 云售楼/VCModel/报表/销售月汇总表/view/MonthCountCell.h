//
//  MonthCountCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LHYChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MonthCountCell : UITableViewCell

@property (nonatomic, strong) LHYChartView *chartView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END

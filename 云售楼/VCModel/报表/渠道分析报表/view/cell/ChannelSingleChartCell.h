//
//  ChannelSingleChartCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SingleBarChartView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChannelSingleChartCellBlock)(NSInteger index);

@interface ChannelSingleChartCell : UITableViewCell

@property (nonatomic, copy) ChannelSingleChartCellBlock channelSingleChartCellBlock;

@property (nonatomic, strong) SingleBarChartView *singleBarChartView;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

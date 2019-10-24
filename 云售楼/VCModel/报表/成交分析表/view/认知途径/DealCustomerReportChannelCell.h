//
//  DealCustomerReportChannelCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SingleBarChartView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DealCustomerReportChannelCellBlock)(NSInteger index);

@interface DealCustomerReportChannelCell : UITableViewCell

@property (nonatomic, copy) DealCustomerReportChannelCellBlock dealCustomerReportChannelCellBlock;

@property (nonatomic, strong) SingleBarChartView *singleBarChartView;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

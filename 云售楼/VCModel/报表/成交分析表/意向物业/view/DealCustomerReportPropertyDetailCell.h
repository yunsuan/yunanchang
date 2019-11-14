//
//  DealCustomerReportPropertyCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SingleBarChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DealCustomerReportPropertyDetailCell : UITableViewCell

@property (nonatomic, strong) SingleBarChartView *singleBarChartView;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

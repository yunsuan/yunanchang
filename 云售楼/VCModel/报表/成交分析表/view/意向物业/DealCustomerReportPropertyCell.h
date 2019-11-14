//
//  DealCustomerReportPropertyCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SingleBarChartView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DealCustomerReportPropertyCellBlock)(NSInteger index);

@interface DealCustomerReportPropertyCell : UITableViewCell

@property (nonatomic, copy) DealCustomerReportPropertyCellBlock dealCustomerReportPropertyCellBlock;

@property (nonatomic, strong) SingleBarChartView *singleBarChartView;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSDictionary *propertyDic;

@end

NS_ASSUME_NONNULL_END

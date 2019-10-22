//
//  ReceiptCountChartCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptCountChartCell : UITableViewCell

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *percentL;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

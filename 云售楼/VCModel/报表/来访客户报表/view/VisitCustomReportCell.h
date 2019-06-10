//
//  VisitCustomReportCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VisitCustomReportCell : UITableViewCell

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *percentL;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSDictionary *approachDic;

@property (nonatomic, strong) NSDictionary *propertyDic;

@end

NS_ASSUME_NONNULL_END

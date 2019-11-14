//
//  AddOrderRentalDetailCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRentalDetailCellBlock)(NSInteger idx);

@interface AddOrderRentalDetailCell : UITableViewCell

@property (nonatomic, copy) AddOrderRentalDetailCellBlock addOrderRentalDetailCellBlock;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *rentL;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) UILabel *originL;

@property (nonatomic, strong) UILabel *resultL;

@property (nonatomic, strong) UILabel *payTimeL;

@property (nonatomic, strong) UILabel *remindL;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

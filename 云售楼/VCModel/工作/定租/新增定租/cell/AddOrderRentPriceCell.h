//
//  AddOrderRentPriceCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRentPriceCellBlock)(void);

typedef void(^AddOrderRentPriceCellAddBlock)(void);

@interface AddOrderRentPriceCell : UITableViewCell

@property (nonatomic, copy) AddOrderRentPriceCellBlock addOrderRentPriceCellBlock;

@property (nonatomic, copy) AddOrderRentPriceCellAddBlock addOrderRentPriceCellAddBlock;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

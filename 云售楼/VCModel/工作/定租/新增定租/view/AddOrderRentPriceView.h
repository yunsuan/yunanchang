//
//  AddOrderRentPriceView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRentPriceViewBlock)(void);

typedef void(^AddOrderRentPriceViewAddBlock)(void);

@interface AddOrderRentPriceView : UIView

@property (nonatomic, copy) AddOrderRentPriceViewBlock addOrderRentPriceViewBlock;

@property (nonatomic, copy) AddOrderRentPriceViewAddBlock addOrderRentPriceViewAddBlock;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

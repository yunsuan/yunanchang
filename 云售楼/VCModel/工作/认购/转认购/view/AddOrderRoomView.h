//
//  AddOrderRoomView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRoomViewEditBlock)(void);

@interface AddOrderRoomView : UIView

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) BorderTextField *roomTF;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) BorderTextField *buildTF;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) BorderTextField *unitTF;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) BorderTextField *floorTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTextField *priceTF;

@property (nonatomic, strong) UILabel *ruleL;

@property (nonatomic, strong) BorderTextField *ruleTF;

@property (nonatomic, strong) UILabel *unitPriceL;

@property (nonatomic, strong) BorderTextField *unitPriceTF;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) BorderTextField *totalTF;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) BorderTextField *propertyTF;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) BorderTextField *areaTF;

@property (nonatomic, strong) UILabel *innerL;

@property (nonatomic, strong) BorderTextField *innerTF;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) BorderTextField *typeTF;

@end

NS_ASSUME_NONNULL_END

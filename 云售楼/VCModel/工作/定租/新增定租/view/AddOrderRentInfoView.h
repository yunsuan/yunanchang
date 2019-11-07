//
//  AddOrderRentInfoView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRentInfoViewStrBlock)(NSString *str, NSInteger idx);

typedef void(^AddOrderRentInfoViewBtnBlock)(NSInteger idx);

@interface AddOrderRentInfoView : UIView

@property (nonatomic, copy) AddOrderRentInfoViewStrBlock addOrderRentInfoViewStrBlock;

@property (nonatomic, copy) AddOrderRentInfoViewBtnBlock addOrderRentInfoViewBtnBlock;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTextField *codeTF;

@property (nonatomic, strong) UILabel *signerL;

@property (nonatomic, strong) BorderTextField *signerTF;

@property (nonatomic, strong) UILabel *signTypeL;

@property (nonatomic, strong) DropBtn *signTypeBtn;

@property (nonatomic, strong) UILabel *signNumL;

@property (nonatomic, strong) BorderTextField *signNumTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTextField *priceTF;

@property (nonatomic, strong) DropBtn *intentPeriodLBtn1;

@property (nonatomic, strong) UILabel *intentPeriodL;

@property (nonatomic, strong) DropBtn *intentPeriodLBtn2;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropBtn *payWayBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

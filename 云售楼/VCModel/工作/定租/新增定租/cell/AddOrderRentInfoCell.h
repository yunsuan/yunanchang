//
//  AddOrderRentInfoCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRentInfoCellStrBlock)(NSString *str, NSInteger idx);

typedef void(^AddOrderRentInfoCellBtnBlock)(NSInteger idx);

@interface AddOrderRentInfoCell : UITableViewCell

@property (nonatomic, copy) AddOrderRentInfoCellStrBlock addOrderRentInfoCellStrBlock;

@property (nonatomic, copy) AddOrderRentInfoCellBtnBlock addOrderRentInfoCellBtnBlock;

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

@property (nonatomic, strong) UILabel *openTimeL;

@property (nonatomic, strong) DropBtn *openTimeBtn;

@property (nonatomic, strong) UILabel *signTimeL;

@property (nonatomic, strong) DropBtn *signTimeBtn;

@property (nonatomic, strong) UILabel *remindTimeL;

@property (nonatomic, strong) DropBtn *remindTimeBtn;

@property (nonatomic, strong) UILabel *rentTimeBeginL;

@property (nonatomic, strong) DropBtn *rentTimeBeginBtn;

@property (nonatomic, strong) UILabel *rentTimePeriodL;

@property (nonatomic, strong) DropBtn *rentTimePeriodTF;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropBtn *payWayBtn1;

@property (nonatomic, strong) DropBtn *payWayBtn2;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) BorderTextField *depositTF;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *signDic;

@end

NS_ASSUME_NONNULL_END

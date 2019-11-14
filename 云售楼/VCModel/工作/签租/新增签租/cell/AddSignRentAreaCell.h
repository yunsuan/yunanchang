//
//  AddSignRentAreaCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddSignRentAreaCellStrBlock)(NSString *str);

@interface AddSignRentAreaCell : UITableViewCell

@property (nonatomic, copy) AddSignRentAreaCellStrBlock addSignRentAreaCellStrBlock;

@property (nonatomic, strong) UILabel *rentAreaL;

@property (nonatomic, strong) UILabel *chargeAreaL;

@property (nonatomic, strong) BorderTextField *chargeAreaTF;

@property (nonatomic, strong) UILabel *realAreaL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

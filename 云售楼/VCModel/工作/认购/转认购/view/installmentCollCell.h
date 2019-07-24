//
//  installmentCollCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^InstallmentCollCellAddBlock)(NSInteger index);

typedef void(^InstallmentCollCellTimeBlock)(NSInteger index);

typedef void(^InstallmentCollCellStrBlock)(NSInteger index, NSString *str);

@interface installmentCollCell : UICollectionViewCell

@property (nonatomic, copy) InstallmentCollCellAddBlock installmentCollCellAddBlock;

@property (nonatomic, copy) InstallmentCollCellTimeBlock installmentCollCellTimeBlock;

@property (nonatomic, copy) InstallmentCollCellStrBlock installmentCollCellStrBlock;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) BorderTextField *payTF;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

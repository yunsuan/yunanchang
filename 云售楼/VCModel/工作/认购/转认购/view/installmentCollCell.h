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

@interface installmentCollCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) BorderTextField *payTF;

@end

NS_ASSUME_NONNULL_END

//
//  AddNumeralInfoCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralInfoCellDropBlock)(void);

typedef void(^AddNumeralInfoCellStrBlock)(NSString *str ,NSInteger num);

@interface AddNumeralInfoCell : UITableViewCell

@property (nonatomic, copy) AddNumeralInfoCellDropBlock addNumeralInfoCellDropBlock;

@property (nonatomic, copy) AddNumeralInfoCellStrBlock addNumeralInfoCellStrBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) BorderTextField *numTF;

@property (nonatomic, strong) UILabel *freeL;

@property (nonatomic, strong) BorderTextField *freeTF;

@property (nonatomic, strong) NSMutableArray *typeArr;

@end

NS_ASSUME_NONNULL_END

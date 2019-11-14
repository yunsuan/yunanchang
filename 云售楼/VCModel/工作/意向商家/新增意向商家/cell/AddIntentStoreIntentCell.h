//
//  AddIntentStoreIntentCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreIntentCellStrBlock)(NSString *str, NSInteger idx);

typedef void(^AddIntentStoreIntentCellTimeBlock)(void);

typedef void(^AddIntentStoreIntentCellPeriod1Block)(void);

typedef void(^AddIntentStoreIntentCellPeriod2Block)(void);

@interface AddIntentStoreIntentCell : UITableViewCell

@property (nonatomic, copy) AddIntentStoreIntentCellStrBlock addIntentStoreIntentCellStrBlock;

@property (nonatomic, copy) AddIntentStoreIntentCellTimeBlock addIntentStoreIntentCellTimeBlock;

@property (nonatomic, copy) AddIntentStoreIntentCellPeriod1Block addIntentStoreIntentCellPeriod1Block;

@property (nonatomic, copy) AddIntentStoreIntentCellPeriod2Block addIntentStoreIntentCellPeriod2Block;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTextField *codeTF;

@property (nonatomic, strong) UILabel *sincerityL;

@property (nonatomic, strong) BorderTextField *sincerityTF;

@property (nonatomic, strong) UILabel *intentPeriodL;

@property (nonatomic, strong) DropBtn *intentPeriodLBtn1;

@property (nonatomic, strong) DropBtn *intentPeriodLBtn2;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

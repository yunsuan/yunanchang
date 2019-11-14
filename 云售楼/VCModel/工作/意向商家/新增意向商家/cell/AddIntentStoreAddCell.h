//
//  AddIntentStoreAddCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreAddCellBlock)(void);

@interface AddIntentStoreAddCell : UITableViewCell

@property (nonatomic, copy) AddIntentStoreAddCellBlock addIntentStoreAddCellBlock;

@property (nonatomic, strong) UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END

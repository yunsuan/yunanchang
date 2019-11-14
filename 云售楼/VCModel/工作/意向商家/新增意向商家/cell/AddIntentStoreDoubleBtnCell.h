//
//  AddIntentStoreDoubleBtnCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreDoubleBtnCellAddBlock)(void);

typedef void(^AddIntentStoreDoubleBtnCellSelectBlock)(void);

@interface AddIntentStoreDoubleBtnCell : UITableViewCell

@property (nonatomic, copy) AddIntentStoreDoubleBtnCellAddBlock addIntentStoreDoubleBtnCellAddBlock;

@property (nonatomic, copy) AddIntentStoreDoubleBtnCellSelectBlock addIntentStoreDoubleBtnCellSelectBlock;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END

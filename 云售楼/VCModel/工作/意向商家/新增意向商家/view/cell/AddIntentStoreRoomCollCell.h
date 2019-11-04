//
//  AddIntentStoreRoomCollCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreRoomCollCellDeleteBlock)(NSInteger idx);

@interface AddIntentStoreRoomCollCell : UICollectionViewCell

@property (nonatomic, strong) AddIntentStoreRoomCollCellDeleteBlock addIntentStoreRoomCollCellDeleteBlock;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END

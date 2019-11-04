//
//  AddIntentStoreRoomView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreRoomViewAddBlock)(void);
typedef void(^AddIntentStoreRoomViewDeleteBlock)(NSInteger idx);

@interface AddIntentStoreRoomView : UIView

@property (nonatomic, copy) AddIntentStoreRoomViewAddBlock addIntentStoreRoomViewAddBlock;

@property (nonatomic, copy) AddIntentStoreRoomViewDeleteBlock addIntentStoreRoomViewDeleteBlock;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

NS_ASSUME_NONNULL_END

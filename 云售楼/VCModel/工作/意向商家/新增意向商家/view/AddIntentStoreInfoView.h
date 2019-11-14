//
//  AddIntentStoreInfoView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreInfoViewAddBlock)(void);
typedef void(^AddIntentStoreInfoViewSelectBlock)(void);
typedef void(^AddIntentStoreInfoViewDeleteBlock)(NSInteger idx);

@interface AddIntentStoreInfoView : UIView

@property (nonatomic, copy) AddIntentStoreInfoViewAddBlock addIntentStoreInfoViewAddBlock;

@property (nonatomic, copy) AddIntentStoreInfoViewSelectBlock addIntentStoreInfoViewSelectBlock;

@property (nonatomic, copy) AddIntentStoreInfoViewDeleteBlock addIntentStoreInfoViewDeleteBlock;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

NS_ASSUME_NONNULL_END

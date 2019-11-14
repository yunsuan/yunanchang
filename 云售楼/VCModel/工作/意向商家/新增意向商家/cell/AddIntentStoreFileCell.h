//
//  AddIntentStoreFileCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreFileCellDeleteBlock)(NSInteger idx);
typedef void(^AddIntentStoreFileCellSelectBlock)(NSInteger idx);

@interface AddIntentStoreFileCell : UITableViewCell

@property (nonatomic, copy) AddIntentStoreFileCellDeleteBlock addIntentStoreFileCellDeleteBlock;

@property (nonatomic, copy) AddIntentStoreFileCellSelectBlock addIntentStoreFileCellSelectBlock;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

NS_ASSUME_NONNULL_END

//
//  AddIntentStoreInfoCollCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreInfoCollCellDeleteBlock)(NSInteger idx);

@interface AddIntentStoreInfoCollCell : UICollectionViewCell

@property (nonatomic, strong) AddIntentStoreInfoCollCellDeleteBlock addIntentStoreInfoCollCellDeleteBlock;

@end

NS_ASSUME_NONNULL_END

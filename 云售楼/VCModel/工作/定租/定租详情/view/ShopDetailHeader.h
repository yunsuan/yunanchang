//
//  ShopDetailHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShopDetailHeaderAddBlock)(void);

typedef void(^ShopDetailHeaderEditBlock)(void);

typedef void(^ShopDetailHeaderCollBlock)(NSInteger index);

@interface ShopDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) ShopDetailHeaderCollBlock shopDetailHeaderCollBlock;

@property (nonatomic, copy) ShopDetailHeaderAddBlock shopDetailHeaderAddBlock;

@property (nonatomic, copy) ShopDetailHeaderEditBlock shopDetailHeaderEditBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *customL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *moneyL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSDictionary *storeIntentDic;

@end

NS_ASSUME_NONNULL_END

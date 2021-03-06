//
//  NumeralDetailHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumeralDetailHeaderAddBlock)(void);

typedef void(^NumeralDetailHeaderEditBlock)(void);

typedef void(^NumeralDetailHeaderCollBlock)(NSInteger index);

@interface NumeralDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) NumeralDetailHeaderCollBlock numeralDetailHeaderCollBlock;

@property (nonatomic, copy) NumeralDetailHeaderAddBlock numeralDetailHeaderAddBlock;

@property (nonatomic, copy) NumeralDetailHeaderEditBlock numeralDetailHeaderEditBlock;

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

@property (nonatomic, strong) NSDictionary *orderDic;

@property (nonatomic, strong) NSDictionary *signDic;

@end

NS_ASSUME_NONNULL_END

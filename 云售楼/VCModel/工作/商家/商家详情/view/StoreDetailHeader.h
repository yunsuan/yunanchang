//
//  StoreDetailHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreDetailHeaderTagBlock)(NSInteger index);

typedef void(^StoreDetailHeaderEditBlock)(NSInteger index);

@interface StoreDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) StoreDetailHeaderTagBlock storeDetailHeaderTagBlock;

@property (nonatomic, copy) StoreDetailHeaderEditBlock storeDetailHeaderEditBlock;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) BaseHeader *header;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *formatL;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) UILabel *nickL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *brandL;

@property (nonatomic, strong) UILabel *approchL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *contractL;

@property (nonatomic, strong) UILabel *phoneL1;

@property (nonatomic, strong) UILabel *phoneL2;

@property (nonatomic, strong) UILabel *phoneL3;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *descL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

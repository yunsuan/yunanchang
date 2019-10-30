//
//  StoreDetailHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreDetailHeaderTagBlock)(NSInteger index);

typedef void(^StoreDetailHeaderEditBlock)(NSInteger index);

@interface StoreDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) StoreDetailHeaderTagBlock storeDetailHeaderTagBlock;

@property (nonatomic, copy) StoreDetailHeaderEditBlock storeDetailHeaderEditBlock;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *formatL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, strong) UIButton *brandBtn;

@end

NS_ASSUME_NONNULL_END

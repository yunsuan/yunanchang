//
//  CallTelegramCustomDetailHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"
#import "CallTelegramCustomDetailHeaderCollCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramCustomDetailHeaderTagBlock)(NSInteger index);

typedef void(^CallTelegramCustomDetailHeaderEditBlock)(NSInteger index);

typedef void(^CallTelegramCustomDetailHeaderDeleteBlock)(NSInteger index);

typedef void(^CallTelegramCustomDetailHeaderAddBlock)(NSInteger index);

@interface CallTelegramCustomDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, copy) CallTelegramCustomDetailHeaderTagBlock callTelegramCustomDetailHeaderTagBlock;

@property (nonatomic, copy) CallTelegramCustomDetailHeaderEditBlock callTelegramCustomDetailHeaderEditBlock;

@property (nonatomic, copy) CallTelegramCustomDetailHeaderDeleteBlock callTelegramCustomDetailHeaderDeleteBlock;

@property (nonatomic, copy) CallTelegramCustomDetailHeaderAddBlock callTelegramCustomDetailHeaderAddBlock;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *customSourceL;

@property (nonatomic, strong) UILabel *sourceTypeL;

@property (nonatomic, strong) UILabel *approachL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *groupColl;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, strong) UIButton *intentBtn;

@end

NS_ASSUME_NONNULL_END

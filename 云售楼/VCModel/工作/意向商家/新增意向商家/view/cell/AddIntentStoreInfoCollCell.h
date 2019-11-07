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

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *customL;

@property (nonatomic, strong) UILabel *ascriptionL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

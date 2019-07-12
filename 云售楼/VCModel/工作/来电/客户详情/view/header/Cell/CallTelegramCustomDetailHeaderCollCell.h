//
//  CallTelegramCustomDetailHeaderCollCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramCustomDetailHeaderCollCellDeleteBlock)(NSInteger index);

@interface CallTelegramCustomDetailHeaderCollCell : UICollectionViewCell

@property (nonatomic, copy) CallTelegramCustomDetailHeaderCollCellDeleteBlock callTelegramCustomDetailHeaderCollCellDeleteBlock;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) NSInteger isSelect;

@property (nonatomic, strong) UILabel *titleL;

@end

NS_ASSUME_NONNULL_END

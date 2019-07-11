//
//  preferentialCollCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PreferentialCollCellDeleteBlock)(NSInteger index);

@interface preferentialCollCell : UICollectionViewCell

@property (nonatomic, copy) PreferentialCollCellDeleteBlock preferentialCollCellDeleteBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UILabel *perferL;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

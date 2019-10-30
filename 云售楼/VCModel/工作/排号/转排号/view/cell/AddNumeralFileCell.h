//
//  AddNumeralFileCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralFileCellDeleteBlock)(NSInteger idx);

@interface AddNumeralFileCell : UICollectionViewCell

@property (nonatomic, copy) AddNumeralFileCellDeleteBlock addNumeralFileCellDeleteBlock;

@property (nonatomic, strong) UIImageView *bigImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END

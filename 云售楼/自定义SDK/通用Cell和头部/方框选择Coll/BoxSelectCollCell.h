//
//  BoxSelectCollCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoxSelectCollCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger isSelect;

@property (nonatomic, strong) UIImageView *selectImg;

@property (nonatomic, strong) UILabel *titleL;

@end

NS_ASSUME_NONNULL_END

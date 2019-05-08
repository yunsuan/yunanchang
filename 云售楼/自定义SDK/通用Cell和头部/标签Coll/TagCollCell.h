//
//  TagCollCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagCollCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *contentL;

- (void)setStyleByType:(NSString *)type lab:(NSString *)str;

@end

NS_ASSUME_NONNULL_END

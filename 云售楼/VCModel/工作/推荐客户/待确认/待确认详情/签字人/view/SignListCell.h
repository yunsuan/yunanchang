//
//  SignListCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignListCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIImageView *circleImg;

@property (nonatomic, strong) UIView *upLine;

@property (nonatomic, strong) UIView *downLine;

@end

NS_ASSUME_NONNULL_END

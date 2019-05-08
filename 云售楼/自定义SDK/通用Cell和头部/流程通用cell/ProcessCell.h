//
//  ProgressCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProcessCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *circleImg;

@property (nonatomic, strong) UIView *upLine;

@property (nonatomic, strong) UIView *downLine;

@end

NS_ASSUME_NONNULL_END

//
//  WorkCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkCell : UITableViewCell


@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *topContentL;

@property (nonatomic, strong) UILabel *bomContentL;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UIView *lineView;

- (void)SetImg:(NSString *)img title:(NSString *)title content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END

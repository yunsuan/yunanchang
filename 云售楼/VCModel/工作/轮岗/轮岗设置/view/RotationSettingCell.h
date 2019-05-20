//
//  RotationSettingCell.h
//  云售楼
//
//  Created by xiaoq on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RotationSettingCell : UITableViewCell
@property (nonatomic , strong) UIImageView *selectImg;
@property (nonatomic , strong) UIImageView *headerImg;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *phoneL;
@property (nonatomic , strong) NSIndexPath *index;
@property (nonatomic , strong) UIButton *deleteBtn;
@property (nonatomic , strong) UIButton *sleepBtn;


@end

NS_ASSUME_NONNULL_END

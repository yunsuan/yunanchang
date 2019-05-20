//
//  PushSettingCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PushSettingCellSwitchBlock)(void);

@interface PushSettingCell : UITableViewCell

@property (nonatomic, copy) PushSettingCellSwitchBlock pushSettingCellSwitchBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIImageView *rightView;

@property (nonatomic, strong) UISwitch *OnOff;

@end

NS_ASSUME_NONNULL_END

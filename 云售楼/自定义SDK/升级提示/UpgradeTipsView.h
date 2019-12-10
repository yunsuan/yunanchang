//
//  UpgradeTipsView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UpgradeTipsViewBlock)(void);

@interface UpgradeTipsView : UIView

@property (nonatomic, copy) UpgradeTipsViewBlock upgradeTipsViewBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END

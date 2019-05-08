//
//  PersonalHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PersonalHeaderBlock)(void);

@interface PersonalHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) PersonalHeaderBlock personalHeaderBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headerImg;

//@property (nonatomic, strong) uiima *<#class#>;

@end

NS_ASSUME_NONNULL_END

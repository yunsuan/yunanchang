//
//  InstallMentDetailCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstallMentDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *moneyL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *remindTimeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

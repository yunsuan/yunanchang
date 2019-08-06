//
//  CallTelegramCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramCellBlock)(void);

@interface CallTelegramCell : UITableViewCell

@property (nonatomic, copy) CallTelegramCellBlock callTelegramCellBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *groupL;

@property (nonatomic, strong) UILabel *effectTagL;

@property (nonatomic, strong) UILabel *dayL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

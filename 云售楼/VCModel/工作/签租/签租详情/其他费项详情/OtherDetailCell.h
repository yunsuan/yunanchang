//
//  OtherDetailCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OtherDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UILabel *payTimeL;

@property (nonatomic, strong) UILabel *remindL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

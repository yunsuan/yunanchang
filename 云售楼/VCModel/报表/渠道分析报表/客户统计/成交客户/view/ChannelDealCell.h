//
//  ChannelDealCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelDealCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END

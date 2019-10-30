//
//  StoreCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *customL;

@property (nonatomic, strong) UILabel *ascriptionL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

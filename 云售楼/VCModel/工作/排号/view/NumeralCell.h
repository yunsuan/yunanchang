//
//  NumeralCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NumeralCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *customL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *consultantL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSDictionary *orderDic;

@property (nonatomic, strong) NSDictionary *signDic;

@end

NS_ASSUME_NONNULL_END

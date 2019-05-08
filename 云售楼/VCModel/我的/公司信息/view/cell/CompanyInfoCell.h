//
//  CompanyInfoCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyInfoCell : UITableViewCell

@property (nonatomic, strong) UIView *upLine;

@property (nonatomic, strong) UIImageView *circleImg;

@property (nonatomic, strong) UIView *downLine;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *departL;

@property (nonatomic, strong) UILabel *positionL;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

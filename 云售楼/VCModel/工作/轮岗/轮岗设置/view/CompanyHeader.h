//
//  CompanyHeader.h
//  云售楼
//
//  Created by xiaoq on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *explainL;

@property (nonatomic , strong) UIButton *addBtn;


@end

NS_ASSUME_NONNULL_END

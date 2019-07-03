//
//  AddNumeralProcessCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddNumeralProcessCell : UITableViewCell

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) DropBtn *auditBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@end

NS_ASSUME_NONNULL_END

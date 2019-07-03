//
//  NumeralDetailAuditAdviseCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface NumeralDetailAuditAdviseCell : UITableViewCell

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *nextL;

@property (nonatomic, strong) DropBtn *nextBtn;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) DropBtn *auditBtn;

@end

NS_ASSUME_NONNULL_END

//
//  NumeralDetailInvalidView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumeralDetailInvalidViewBlock)(void);

@interface NumeralDetailInvalidView : UIView

@property (nonatomic, copy) NumeralDetailInvalidViewBlock numeralDetailInvalidViewBlock;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

NS_ASSUME_NONNULL_END

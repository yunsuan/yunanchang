//
//  NumeralBackNumView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumeralBackNumViewTypeBlock)(void);

typedef void(^NumeralBackNumViewAuditBlock)(void);

typedef void(^NumeralBackNumViewRoleBlock)(void);

typedef void(^NumeralBackNumViewPersonBlock)(void);

@interface NumeralBackNumView : UIView

@property (nonatomic, copy) NumeralBackNumViewTypeBlock numeralBackNumViewTypeBlock;

@property (nonatomic, copy) NumeralBackNumViewAuditBlock numeralBackNumViewAuditBlock;

@property (nonatomic, copy) NumeralBackNumViewRoleBlock numeralBackNumViewRoleBlock;

@property (nonatomic, copy) NumeralBackNumViewPersonBlock numeralBackNumViewPersonBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *personArr;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) DropBtn *auditBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) DropBtn *roleBtn;

@property (nonatomic, strong) UILabel *personL;

@property (nonatomic, strong) DropBtn *personBtn;
@end

NS_ASSUME_NONNULL_END

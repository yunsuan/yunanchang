//
//  SincerityChangeView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SincerityChangeViewTypeBlock)(void);

typedef void(^SincerityChangeViewAuditBlock)(void);

typedef void(^SincerityChangeViewRoleBlock)(void);

typedef void(^SincerityChangeViewPersonBlock)(void);

typedef void(^SincerityChangeViewStrBlock)(NSString *str);

@interface SincerityChangeView : UIView

@property (nonatomic, copy) SincerityChangeViewTypeBlock sincerityChangeViewTypeBlock;

@property (nonatomic, copy) SincerityChangeViewAuditBlock sincerityChangeViewAuditBlock;

@property (nonatomic, copy) SincerityChangeViewRoleBlock sincerityChangeViewRoleBlock;

@property (nonatomic, copy) SincerityChangeViewPersonBlock sincerityChangeViewPersonBlock;

@property (nonatomic, copy) SincerityChangeViewStrBlock sincerityChangeViewStrBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *personArr;

@property (nonatomic, strong) UILabel *originL;

@property (nonatomic, strong) BorderTextField *originTF;

@property (nonatomic, strong) UILabel *sinceL;

@property (nonatomic, strong) BorderTextField *sinceTF;

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

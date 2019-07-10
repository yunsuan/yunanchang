//
//  AddNumeralProcessView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropBtn.h"
#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralProcessViewTypeBlock)(void);

typedef void(^AddNumeralProcessViewAuditBlock)(void);

typedef void(^AddNumeralProcessViewRoleBlock)(void);

typedef void(^AddNumeralProcessViewFinalBlock)(void);

@interface AddNumeralProcessView : UIView

@property (nonatomic, copy) AddNumeralProcessViewTypeBlock addNumeralProcessViewTypeBlock;

@property (nonatomic, copy) AddNumeralProcessViewAuditBlock addNumeralProcessViewAuditBlock;

@property (nonatomic, copy) AddNumeralProcessViewRoleBlock addNumeralProcessViewRoleBlock;

@property (nonatomic, copy) AddNumeralProcessViewFinalBlock addNumeralProcessViewFinalBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) DropBtn *auditBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) DropBtn *roleBtn;

@property (nonatomic, strong) UILabel *personL;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UILabel *finalL;

@property (nonatomic, strong) DropBtn *finalBtn;

@end

NS_ASSUME_NONNULL_END

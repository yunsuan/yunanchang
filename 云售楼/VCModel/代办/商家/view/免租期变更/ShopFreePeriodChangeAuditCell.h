//
//  ShopFreePeriodChangeCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/12/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShopFreePeriodChangeAuditCellAuditBlock)(NSInteger index);

@interface ShopFreePeriodChangeAuditCell : UITableViewCell

@property (nonatomic, copy) ShopFreePeriodChangeAuditCellAuditBlock shopFreePeriodChangeAuditCellAuditBlock;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *contractL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *shopNameL;

@property (nonatomic, strong) UILabel *shopCodeL;

@property (nonatomic, strong) UILabel *advicerL;

@property (nonatomic, strong) UILabel *originPeriodL;

@property (nonatomic, strong) UILabel *changePeriodL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UIButton *auditBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

//
//  StoreSignAuditCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreSignAuditCellAuditBlock)(NSInteger index);

@interface StoreSignAuditCell : UITableViewCell

@property (nonatomic, copy) StoreSignAuditCellAuditBlock storeSignAuditCellAuditBlock;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *contractL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *intentCodeL;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) UILabel *intentNumL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *consultantL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *otherL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UIButton *auditBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

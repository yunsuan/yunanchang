//
//  StoreOrderAuditCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreOrderAuditCellAuditBlock)(NSInteger index);

@interface StoreOrderAuditCell : UITableViewCell

@property (nonatomic, copy) StoreOrderAuditCellAuditBlock storeOrderAuditCellAuditBlock;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *contractL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) UILabel *intentCodeL;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) UILabel *intentNumL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *consultantL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UIButton *auditBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

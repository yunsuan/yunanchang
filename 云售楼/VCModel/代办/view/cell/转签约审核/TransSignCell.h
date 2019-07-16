//
//  TransSignCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TransSignCellAuditBlock)(NSInteger index);

@interface TransSignCell : UITableViewCell

@property (nonatomic, copy) TransSignCellAuditBlock transSignCellAuditBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *allPriceL;

@property (nonatomic, strong) UILabel *donePriceL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *consultantL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UIButton *auditBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

//
//  RoomPriceCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoomPriceCellAuditBlock)(NSInteger index);

@interface RoomPriceCell : UITableViewCell

@property (nonatomic, copy) RoomPriceCellAuditBlock roomPriceCellAuditBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *infoL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UIButton *auditBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

//
//  ZQDataGridLeftTabelViewCell.h
//  XPMS
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ZQDataGridBaseCell.h"
#import "ZQDataGridLeftTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQDataGridLeftTabelViewCell : ZQDataGridBaseCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *rightLine;
@property (nonatomic, strong) UIView  *bottomLine;
@property (nonatomic, strong) ZQDataGridLeftTableViewCellModel *cellModel;

@end

NS_ASSUME_NONNULL_END

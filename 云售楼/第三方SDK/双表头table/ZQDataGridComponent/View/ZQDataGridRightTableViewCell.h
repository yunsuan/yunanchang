//
//  ZQDataGridRightTableViewCell.h
//  XPMS
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ZQDataGridBaseCell.h"
#import "ZQDataGridRowViewCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQDataGridRightTableViewCell : ZQDataGridBaseCell
@property (nonatomic, strong) ZQDataGridRightTableViewCellModel *dataModel;
@property (nonatomic,copy) colloctionViewItemClick itemClick;

@end

NS_ASSUME_NONNULL_END

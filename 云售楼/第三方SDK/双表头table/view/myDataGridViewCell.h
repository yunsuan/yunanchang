//
//  myDataGridViewCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZQDataGridLeftTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface myDataGridViewCell : UICollectionViewCell

@property (nonatomic, strong) ZQDataGridLeftTableViewCellModel *itemModel;

@end

NS_ASSUME_NONNULL_END

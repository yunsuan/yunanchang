//
//  ZQDataGridRowViewCollectionView.h
//  XPMS
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ZQHeader.h"
#import <UIKit/UIKit.h>
#import "ZQDataGridRightTableViewCellModel.h"

typedef void (^colloctionViewItemClick)(NSInteger row,NSInteger column,UIView * _Nullable tagetView);
NS_ASSUME_NONNULL_BEGIN

@interface ZQDataGridRowViewCollectionView : UIView
@property (nonatomic, strong) ZQDataGridRightTableViewCellModel *dataModel;
@property (nonatomic,copy) colloctionViewItemClick itemClick;

@end

NS_ASSUME_NONNULL_END

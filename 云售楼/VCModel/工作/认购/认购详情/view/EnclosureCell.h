//
//  EnclosureCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface EnclosureCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

NS_ASSUME_NONNULL_END

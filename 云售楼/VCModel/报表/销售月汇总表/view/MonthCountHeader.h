//
//  MonthCountHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MonthCountHeaderBlock)(NSInteger index);

@interface MonthCountHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) MonthCountHeaderBlock monthCountHeaderBlock;

//@property (nonatomic, strong) NSMutableArray *
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

NS_ASSUME_NONNULL_END

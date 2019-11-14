//
//  AddIntentStoreProccessCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropBtn.h"
#import "GZQFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreProccessCellTypeBlock)(void);

typedef void(^AddIntentStoreProccessCellAuditBlock)(void);

typedef void(^AddIntentStoreProccessCellRoleBlock)(void);

typedef void(^AddIntentStoreProccessCellFinalBlock)(void);

typedef void(^AddIntentStoreProccessCellSelectBlock)(NSArray *arr);

@interface AddIntentStoreProccessCell : UITableViewCell

@property (nonatomic, copy) AddIntentStoreProccessCellTypeBlock addIntentStoreProccessCellTypeBlock;

@property (nonatomic, copy) AddIntentStoreProccessCellAuditBlock addIntentStoreProccessCellAuditBlock;

@property (nonatomic, copy) AddIntentStoreProccessCellRoleBlock addIntentStoreProccessCellRoleBlock;

@property (nonatomic, copy) AddIntentStoreProccessCellFinalBlock addIntentStoreProccessCellFinalBlock;

@property (nonatomic, copy) AddIntentStoreProccessCellSelectBlock addIntentStoreProccessCellSelectBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *personArr;;

@property (nonatomic, strong) NSMutableArray *personSelectArr;;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) DropBtn *auditBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) DropBtn *roleBtn;

@property (nonatomic, strong) UILabel *personL;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UILabel *finalL;

@property (nonatomic, strong) DropBtn *finalBtn;

@end

NS_ASSUME_NONNULL_END

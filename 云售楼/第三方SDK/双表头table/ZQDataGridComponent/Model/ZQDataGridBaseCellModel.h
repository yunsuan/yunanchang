//
//  ZQDataGridBaseCellModel.h
//  XPMS
//
//  Created by 谷治墙 on 2019/1/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQDataGridBaseCellModel : NSObject
@property (nonatomic, assign) NSInteger  numOfRowIndex;      // 单元格所在行
@property (nonatomic, assign) NSInteger  numOfColumnNumIndex; // 单元格所在列
@end

NS_ASSUME_NONNULL_END

//
//  VisitCustomHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface VisitCustomHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) BaseHeader *header;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSArray *approachArr;

@property (nonatomic, strong) NSArray *propertyArr;

@end

NS_ASSUME_NONNULL_END

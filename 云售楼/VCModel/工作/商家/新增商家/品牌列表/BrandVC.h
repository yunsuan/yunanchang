//
//  BrandVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/31.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BrandVCBlock)(NSArray *arr);

@interface BrandVC : BaseViewController

@property (nonatomic, copy) BrandVCBlock brandVCBlock;

@property (nonatomic, strong) NSString *project_id;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END

//
//  SelectSpePerferVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectSpePerferVCBlock)(NSDictionary *dic);

@interface SelectSpePerferVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, copy) SelectSpePerferVCBlock selectSpePerferVCBlock;

@property (nonatomic, strong) NSDictionary *dic;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END

//
//  CodeScanVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/9/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    ScanToInput=0,
    InputToScan,
} ScanAnimationTransform;

typedef void(^CodeScanVCBlock)(NSString *str);

@interface CodeScanVC : BaseViewController

@property (nonatomic, copy) CodeScanVCBlock codeScanVCBlock;

@end

NS_ASSUME_NONNULL_END

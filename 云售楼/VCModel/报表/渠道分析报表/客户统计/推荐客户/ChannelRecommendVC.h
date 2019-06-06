//
//  ChannelRecommendVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChannelRecommendVC : BaseViewController

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *search;

- (void)RequestMethod;

@end

NS_ASSUME_NONNULL_END

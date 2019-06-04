//
//  ChannelAnalysisHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChannelAnalysisHeaderBlock)(void);

@interface ChannelAnalysisHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) ChannelAnalysisHeaderBlock channelAnalysisHeaderBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END

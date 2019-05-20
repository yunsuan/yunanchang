//
//  WorkerPickView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkerPickView;
typedef void(^WorkerPickBlock)(NSString * GSMC, NSString * ID, NSString * RYBH, NSString * RYDH, NSString * RYXM, NSString * RYTP);//回传ID和名称

@interface WorkerPickView : UIView

@property(nonatomic, copy) WorkerPickBlock workerPickBlock;
@property (nonatomic , strong) NSString *key;
@property(nonatomic, strong) NSArray * dataSource;

- (instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)date;

@end

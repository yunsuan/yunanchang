//
//  GZQGifFooter.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

//#import "GZQGifFooter.h"

@implementation GZQGifFooter

- (void)prepare{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"1"]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long) i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    [self setTitle:@"—— 已经到底了 ——" forState:MJRefreshStateNoMoreData];
    self.stateLabel.textColor = CL170Color;
    self.stateLabel.font = [UIFont systemFontOfSize:12*SIZE];
    //隐藏时间
//    self.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    self.stateLabel.hidden = NO;
}

@end

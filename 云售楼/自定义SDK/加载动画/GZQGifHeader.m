//
//  GZQGifHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

//#import "GZQGifHeader.h"

@implementation GZQGifHeader

- (void)placeSubviews{
    
    [super placeSubviews];
    
//    self.stateLabel.mas_bottom = self.gifView.mas_bottom;
    self.stateLabel.mj_y += 6 ;
//    self.stateLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
}

- (void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 1; i++) {
        UIImage *image = [UIImage imageNamed:@"1"];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (long i = 1; i <= 7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
//    self.stateLabel.hidden = YES;
    self.stateLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    self.stateLabel.textColor = CLContentLabColor;
    [self setTitle:@"人算不如云算" forState:MJRefreshStateIdle];
    [self setTitle:@"人算不如云算" forState:MJRefreshStatePulling];
    [self setTitle:@"人算不如云算" forState:MJRefreshStateRefreshing];
}

@end

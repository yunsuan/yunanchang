//
//  CalendarsManger.h
//  云渠道
//
//  Created by xiaoq on 2019/2/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarsManger : NSObject
+(instancetype)sharedCalendarsManger;


/**
 *  将App事件添加到系统日历提醒事项，实现闹铃提醒的功能
 *
 *  @param title      事件标题
 *  @param location   事件位置
 *  @param startDate  开始时间
 *  @param endDate    结束时间
 *  @param allDay     是否全天
 *  @param alarmArray 闹钟集合
 */
- (void)createCalendarWithTitle:(NSString *)title location:(NSString *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarmArray:(NSArray *)alarmArray;


@end

NS_ASSUME_NONNULL_END

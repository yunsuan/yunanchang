//
//  CalendarsManger.m
//  云渠道
//
//  Created by xiaoq on 2019/2/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CalendarsManger.h"
#import <EventKit/EventKit.h>
#import <UIKit/UIKit.h>

@implementation CalendarsManger

static CalendarsManger *calendar;

+(instancetype)sharedCalendarsManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[CalendarsManger alloc]init];
        
    });
    return calendar;
}

-(void)createCalendarWithTitle:(NSString *)title location:(NSString *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarmArray:(NSArray *)alarmArray
{
    __weak typeof(self) weakSelf = self;
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (error)
                {
//                    [strongSelf showAlert:@"添加失败，请稍后重试"];
                    
                }else if (!granted){
//                    [strongSelf showAlert:@"不允许使用日历,请在设置中允许此App使用日历"];
                    
                }else{
                    
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = title;
                    event.location = location;
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = startDate;
                    event.endDate   = endDate;
                    event.allDay = allDay;
                    
                    //添加提醒
                    if (alarmArray && alarmArray.count > 0) {
                        
                        for (NSString *timeString in alarmArray) {
                            [event addAlarm:[EKAlarm alarmWithRelativeOffset:[timeString integerValue]]];
                        }
                    }
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
//                    [strongSelf showAlert:@"已添加到系统日历中"];
                    
                }
            });
        }];
    }
}

//- (void)showAlert:(NSString *)message
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//}




@end

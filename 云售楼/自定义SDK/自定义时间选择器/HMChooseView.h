//
//  HMChooseView.h
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TimePickerViewDelegate<NSObject>
@optional

//通过协议将选中的时间返回
-(void)timePickerViewDidSelectRow:(NSString *)time;

@end

@class HMChooseView;
typedef void(^dateblock)(NSString * date);

@interface HMChooseView : UIView

@property (nonatomic, weak) id<TimePickerViewDelegate> delegate;

@property (nonatomic, copy) NSString *selectedHour;

@property (nonatomic, copy) NSString *selectedMin;

@property(nonatomic, copy) dateblock dateblock;

/**
 初始化方法
 
 @param startHour 其实时间点 时
 @param endHour 结束时间点 时
 @param period 间隔多少分中
 @return QFTimePickerView实例
 */
- (instancetype)initDatePackerWithStartHour:(NSString *)startHour endHour:(NSString *)endHour period:(NSInteger)period selectedHour:(NSString *)selectedHour selectedMin:(NSString *)selectedMin;

- (void)show;

@end

NS_ASSUME_NONNULL_END

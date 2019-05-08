//
//  DateChooseView.h
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateChooseView;
typedef void(^dateblock)(NSDate * date);
@interface DateChooseView : UIView

@property (nonatomic, strong) UIDatePicker *pickerView;

@property(nonatomic, copy) dateblock dateblock;
@end

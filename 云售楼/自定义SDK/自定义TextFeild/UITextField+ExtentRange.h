//
//  UITextField+ExtentRange.h
//  云渠道
//
//  Created by xiaoq on 2019/3/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YXTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField(ExtentRange)
@property (weak, nonatomic) id<YXTextFieldDelegate> delegate;
//获取焦点的位置
-(NSRange)selectedRange;
//设置焦点的位置
-(void)setSelectedRange:(NSRange)range;
@end

extern NSString * const YXTextFieldDidDeleteBackwardNotification;

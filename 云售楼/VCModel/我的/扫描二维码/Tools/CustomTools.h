//
//  CustomTools.h
//  moneyhll
//
//  Created by 谷治墙 on 16/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomTools : NSObject

/**
 自定义Label
 */
+ (UILabel *_Nullable)labelWithTitle:(NSString *_Nullable)text Font:(NSInteger)font textColor:(UIColor *_Nullable)color;


/**
 自定义button
 */
+ (UIButton *_Nullable)buttonWithTitle:(NSString *_Nonnull)title font:(NSInteger)font titleColor:(UIColor *_Nullable)color Selector:(SEL _Nullable )btnSelect Target:(UIViewController *_Nullable)vc;


/**
 自定义View层上button
 */
+ (UIButton *_Nullable)buttonFromViewWithTitle:(NSString *_Nullable)title font:(NSInteger)font titleColor:(UIColor *_Nullable)color Selector:(SEL _Nonnull )btnSelect Target:(UIView *_Nullable)vc;


/**
 自定义textfield
 */
+ (UITextField *_Nullable)textFieldWithPlaceHolder:(NSString *_Nullable)placeHolder textFont:(NSInteger)font textColor:(UIColor *_Nullable)color;


+ (void)alertActionWithTitle:(NSString *_Nullable)title Message:(NSString *_Nullable)message actionHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler Target:(UIViewController *_Nullable)viewController;

+ (void)showAlert:(NSString *_Nullable)message Target:(UIViewController *_Nullable)viewController;

@end

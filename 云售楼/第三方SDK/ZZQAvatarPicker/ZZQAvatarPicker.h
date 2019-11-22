//
//  ZZQAvatarPicker.h
//  ZZQAvatarPicker
//
//  Created by 谷治墙 on 2018/10/31.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZZQAvatarPicker : NSObject

+ (void)startSelected:(void(^)(UIImage *image))compleiton;

@end

NS_ASSUME_NONNULL_END

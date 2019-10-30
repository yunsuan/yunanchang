//
//  ChangeFileNameView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeFileNameViewBlock)(NSString *name);

@interface ChangeFileNameView : UIView

@property (nonatomic, copy) ChangeFileNameViewBlock changeFileNameViewBlock;

- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

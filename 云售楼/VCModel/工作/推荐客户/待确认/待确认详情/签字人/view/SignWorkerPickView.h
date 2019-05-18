//
//  SignWorkerPickView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SignWorkerPickViewBlock)(NSString * Name, NSString * ID, NSString *tel);//回传ID和名称

@interface SignWorkerPickView : UIView

@property(nonatomic, copy) SignWorkerPickViewBlock signWorkerPickViewBlock;
//@property (nonatomic , strong) NSString *key;
@property(nonatomic, strong) NSArray * dataSource;

- (instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)date;

@end

NS_ASSUME_NONNULL_END

//
//  SinglePickView.h
//  云渠道
//
//  Created by xiaoq on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SinglePickView;
typedef void(^selctblook)(NSString * MC, NSString * ID);//回传ID和名称

typedef void(^SelectNumblook)(NSInteger idx);//回传ID和名称

@interface SinglePickView : UIView

@property(nonatomic, copy) selctblook selectedBlock;

@property(nonatomic, copy) SelectNumblook selectNumblook;
@property (nonatomic , strong) NSString *key;
@property(nonatomic, strong) NSArray * dataSource;

- (instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)date;
@end

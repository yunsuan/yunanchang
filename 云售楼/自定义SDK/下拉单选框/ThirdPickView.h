//
//  ThirdPickView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ThirdPickViewBlock)(NSString *first, NSString *second, NSString *third ,NSString *firstId ,NSString *secondId ,NSString *thirdId);//block 选中的省市地区，id  blook出来

@interface ThirdPickView : UIView

@property(nonatomic, copy) ThirdPickViewBlock thirdPickViewBlock;

- (instancetype)initWithFrame:(CGRect)frame withdata:(NSArray *)data unitName:(NSString *)unitName unitId:(NSString *)unitId;

@end

NS_ASSUME_NONNULL_END

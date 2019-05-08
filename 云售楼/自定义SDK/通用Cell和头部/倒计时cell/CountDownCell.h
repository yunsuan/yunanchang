//
//  CountDownCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CountDownCellBlock)(void);

@interface CountDownCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic , copy) CountDownCellBlock countDownCellBlock;

-(void)setcountdownbyday:(NSInteger )day
                   hours:(NSInteger )hours
                     min:(NSInteger )min
                     sec:(NSInteger )sec;

-(void)setcountdownbyendtime:(NSString *)endtime;

@end

NS_ASSUME_NONNULL_END

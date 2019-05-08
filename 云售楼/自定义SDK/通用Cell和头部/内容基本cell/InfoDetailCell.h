//
//  InfoDetailCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^InfoDetailCellBlock)(void);

@interface InfoDetailCell : UITableViewCell

@property (nonatomic, copy) InfoDetailCellBlock infoDetailCellBlock;

@property (nonatomic , strong) UILabel *contentlab;

@property (nonatomic, strong) UIButton *moreBtn;

-(void)SetCellContentbystring:(NSString *)str;
@end

NS_ASSUME_NONNULL_END

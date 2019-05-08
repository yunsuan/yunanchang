//
//  DropBtn.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DropBtn : UIButton {
    
@public
    NSString *str;
}

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic , strong) UILabel *content;

@property (nonatomic , strong) UIImageView *dropimg;

@end

NS_ASSUME_NONNULL_END

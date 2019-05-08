//
//  SingleHouseCell.h
//  云渠道
//
//  Created by xiaoq on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleHouseCell : UITableViewCell
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *content;

-(void)setcelltitle:(NSString *)title
            content:(NSString *)content;
@end

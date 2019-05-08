//
//  AdressChooseView.h
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdressChooseView;
typedef void(^SelectedHandle)(NSString * province, NSString * city, NSString * area ,NSString *proviceid ,NSString * cityid,NSString *areaid);//block 选中的省市地区，id  blook出来

@interface AdressChooseView : UIView
@property (nonatomic , strong) NSString *key;

@property(nonatomic, copy) SelectedHandle selectedBlock;

- (instancetype)initWithFrame:(CGRect)frame withdata:(NSArray *)data;

@end

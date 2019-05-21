//
//  RotationModel.h
//  云售楼
//
//  Created by xiaoq on 2019/5/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RotationModel : NSObject

@property (nonatomic , strong) NSString *company_id;
@property (nonatomic , strong) NSString *company_name;
@property (nonatomic , strong) NSString *contact;
@property (nonatomic , strong) NSString *contact_tel;
@property (nonatomic , strong) NSString *logo;
@property (nonatomic , strong) NSMutableArray *list;

-(void)setModelBydic:(NSMutableDictionary *)dic;


@end

NS_ASSUME_NONNULL_END

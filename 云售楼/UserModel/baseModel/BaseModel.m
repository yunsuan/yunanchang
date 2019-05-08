//
//  BaseModel.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


-(NSMutableDictionary *)modeltodic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars;
        ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            key = [key substringFromIndex:1];
            id value = [self valueForKey:key];
            
            if (value) {
                
                [dic setValue:value forKey:key];
            }
        }
        // 获得c的父类
        c = [c superclass];
        free(ivars);}
    return dic;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end

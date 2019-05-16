//
//  NSArray+GZQArr.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NSArray+GZQArr.h"

@implementation NSArray (GZQArr)

- (NSString *)descriptionWithLocale:(id)locale{
    NSString *logStr = @"";
    
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        logStr = json;
    }
    
    return logStr;
}

@end

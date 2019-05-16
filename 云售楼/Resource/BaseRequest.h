//
//  BaseRequest.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequest : NSObject

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;

+ (void)UpdateFile:(void (^)(id <AFMultipartFormData> formData))blocks url:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END

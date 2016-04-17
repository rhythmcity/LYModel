//
//  NSObject+LYModel.h
//  JsonModel
//
//  Created by 李言 on 16/3/26.
//  Copyright © 2016年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LYModel)

+ (instancetype)LYModelWithJsonObject:(id)json;

+ (instancetype)LYModelWithDictionary:(NSDictionary *)dic;

@end

@interface NSDictionary (LYModel)

- (NSString *)LYModel_ToJsonString;

- (NSData *)LYModel_ToJsonData;

@end

@interface NSArray (LYModel)

- (NSString *)LYModel_ToJsonString;

- (NSData *)LYModel_ToJsonData;
@end

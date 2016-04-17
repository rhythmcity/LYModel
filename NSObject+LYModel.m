//
//  NSObject+LYModel.m
//  JsonModel
//
//  Created by 李言 on 16/3/26.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "NSObject+LYModel.h"
#import <objc/runtime.h>

@implementation NSObject (LYModel)

+ (instancetype)LYModelWithJsonObject:(id)json {

    id obj =  [[[self class] alloc ] init];
    if (!json|| json == (id)kCFNull) {
        return nil;
    }
    
    NSData *jsondata = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = nil;
    if (jsondata) {
        dic = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:NULL];
    }
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        dic = nil;
    }
    
    if (!obj) {
        return nil;
    }
    
    return [obj LYModelSetWithDictionary:dic];
}

- (instancetype)LYModelSetWithDictionary:(NSDictionary*)dic {
    if (!dic) {
        return nil;
    }
    NSMutableArray * keys = [NSMutableArray array];
    NSMutableArray * attributes = [NSMutableArray array];
    
    unsigned int outCount;
    
    objc_property_t *propertys = class_copyPropertyList([self class], &outCount);
    for (int i =  0; i < outCount; i++) {
        objc_property_t property = propertys[i];
        
        NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
        
        NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        [attributes addObject:propertyAttribute];
    }
    
    free(propertys);
    
    for (NSString *key in keys) {
        if ([dic valueForKey:key] == nil) {
            continue;
        }
        
        [self setValue:[dic valueForKey:key] forKey:key];
    }
    
    return self;;

}


+ (instancetype)LYModelWithDictionary:(NSDictionary *)dic {
    
    if (!dic|| dic == (id)kCFNull) {
        return nil;
    }
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    id obj =  [[[self class] alloc ] init];
    
    if (!obj) {
        return nil;
    }
    
    return [obj LYModelSetWithDictionary:dic];

}

@end


@implementation  NSDictionary (LYModel)

- (NSString *)LYModel_ToJsonString {
    if (![self isKindOfClass:[NSDictionary class]]|| self == (id)kCFNull) {
        return nil;
    }
    return  [[NSString alloc] initWithData:[self LYModel_ToJsonData] encoding:NSUTF8StringEncoding];;
}

- (NSData *)LYModel_ToJsonData {
    if (![self isKindOfClass:[NSDictionary class]] || self == (id)kCFNull) {
        return nil;
    }
    return  [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:NULL];;
}

@end

@implementation NSArray (LYModel)

- (NSString *)LYModel_ToJsonString {
    if (![self isKindOfClass:[NSArray class]] || self == (id)kCFNull) {
        return nil;
    }
    return  [[NSString alloc] initWithData:[self LYModel_ToJsonData] encoding:NSUTF8StringEncoding];;
}

- (NSData *)LYModel_ToJsonData {
    if (![self isKindOfClass:[NSArray class]] || self == (id)kCFNull) {
        return nil;
    }
    return  [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:NULL];;
}

@end

//
//  ORUserSetting.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSUserSetting.h"

@implementation GSUserSetting

+ (BOOL)boolOfKey:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL boolValue = [defaults boolForKey:aKey];
    return boolValue;
}


+ (void)setBool:(BOOL)aBool forKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:aBool forKey:aKey];
}



+ (void)synchronize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
}











+ (NSString *)stringOfKey:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *stringValue = [defaults stringForKey:aKey];
    return stringValue;
}

+ (void)setString:(NSString *)aString forKey:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:aString forKey:aKey];
}


+ (NSNumber *)numberOfKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return nil;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *numberValue = [defaults objectForKey:aKey];
    return numberValue;
}

+ (void)setNumber:(NSNumber *)aNumber forKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:aNumber forKey:aKey];
}

+ (NSDictionary *)dictionaryOfKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return 0;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defaults objectForKey:aKey];
    return dictionary;
}

+ (void)setDictionary:(NSDictionary *)aDictionary forKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return;
    }
    
    NSDictionary *newDic = [self objectFromObject:aDictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:newDic forKey:aKey];
}

+ (id)objectFromObject:(id)aObject
{
    if ([aObject isKindOfClass:[NSString class]] || [aObject isKindOfClass:[NSNumber class]])
    {
        return aObject;
    }
    else if ([aObject isKindOfClass:[NSArray class]])
    {
        NSMutableArray *newArray = [NSMutableArray array];
        for (id arrayObj in aObject)
        {
            id object = [self objectFromObject:arrayObj];
            if (object != nil)
            {
                [newArray addObject:object];
            }
        }
        return newArray;
    }
    else if ([aObject isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        for (NSString *key in [aObject allKeys])
        {
            id object = [self objectFromObject:[aObject objectForKey:key]];
            if (object != nil)
            {
                [newDic setObject:object forKey:key];
            }
        }
        return newDic;
    }
    
    return nil;
}

+ (NSData *)dataOfKey:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:aKey];
    return data;
}

+ (void)setData:(NSData *)aData forKey:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:aData forKey:aKey];
}

+ (NSDictionary *)dictionaryFromPListFile:(NSString *)aPListFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:aPListFile ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    return dictionary;
}

+ (NSValue *)valueOfKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return nil;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSValue *value = [defaults objectForKey:aKey];
    return value;
}

+ (void)setValue:(NSValue *)aValue forKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:aValue forKey:aKey];
}

+ (CGPoint)pointOfKey:(NSString *)aKey
{
    if (aKey.length <= 0) {
        return CGPointZero;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGPoint thePoint = CGPointFromString([defaults objectForKey:aKey]);
    return thePoint;
}

+ (void)setPoint:(CGPoint)aPoint forKey:(NSString *)aKey
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    // Set
    [userDefaults setObject:NSStringFromCGPoint(aPoint) forKey:aKey];
}

+ (void)removeObjectForKey:(NSString *)aKey;
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:aKey];
}

+ (void)deleteData:(NSString *)aKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:aKey];
    [defaults synchronize];
}

+ (void)deleteData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defaults dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        [defaults removeObjectForKey:key];
        [defaults synchronize];
    }
}

@end

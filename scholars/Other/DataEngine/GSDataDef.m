//
//  GSDataDef.m
//  dataModel
//
//  Created by r_zhou on 15/11/27.
//  Copyright © 2015年 r_zhou. All rights reserved.
//

#import "GSDataDef.h"
#import "Jastor.h"

@implementation SCBaseJsonModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end

@implementation SCBasePageListResult

@end

@implementation SCPictureInfo
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        self.photosArray = [[self.photos componentsSeparatedByString:@"|"] mutableCopy];
    }
    return self;
}

@end

@implementation SCPictureList

@end


@implementation SCNewsInfo

@end

@implementation SCNewsList

@end
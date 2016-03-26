//
//  ORSecurityUtil.h
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "CocoaSecurity.h"

@interface SecurityUtil : CocoaSecurity
+ (NSString *)aesEncryptUrs:(NSString *)aString key:(NSString *)aKey;
+ (NSString *)aesDecryptUrs:(NSString *)aString key:(NSString *)aKey;
@end

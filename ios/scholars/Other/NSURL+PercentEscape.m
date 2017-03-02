//
//  NSURL+PercentEscape.m
//  ORead
//
//  Created by noname on 3/5/15.
//  Copyright (c) 2015 oread. All rights reserved.
//

#import "NSURL+PercentEscape.h"

@implementation NSURL(PercentEscape)
+ (instancetype)URLWithPercentEscapeString:(NSString *)URLString
{
    NSURL *nsurl = [NSURL URLWithString:URLString];
    if (!nsurl) {
        nsurl = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return nsurl;
}
@end

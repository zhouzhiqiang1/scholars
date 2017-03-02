//
//  NSURL+PercentEscape.h
//  ORead
//
//  Created by noname on 3/5/15.
//  Copyright (c) 2015 oread. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(PercentEscape)
+ (instancetype)URLWithPercentEscapeString:(NSString *)URLString;
@end

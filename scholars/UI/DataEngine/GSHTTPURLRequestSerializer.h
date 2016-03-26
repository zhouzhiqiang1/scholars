//
//  ORHTTPRequestSerializer.h
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "AFURLRequestSerialization.h"

@interface GSHTTPURLRequestSerializer : AFHTTPRequestSerializer
- (void)setClientInfoToHTTPHeader;
@end

//
//  GSDataDef.m
//  dataModel
//
//  Created by r_zhou on 15/11/27.
//  Copyright © 2015年 r_zhou. All rights reserved.
//

#import "GSDataDef.h"

@implementation YDDataUserInfo

@end

@implementation YDNetworkDataUserInfo

@end
@implementation YDUserinfo
+ (Class)rows_class {
    return [YDNetworkDataUserInfo class];
}
@end
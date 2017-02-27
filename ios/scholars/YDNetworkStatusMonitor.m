//
//  YDNetworkStatusMonitor.m
//  yxtk
//
//  Created by Aren on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YDNetworkStatusMonitor.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Observer.h"
#import "AFNetworking.h"

static NSString * const YDNetworkStatusNone = @"NotReachable";
static NSString * const YDNetworkStatusWiFi = @"WiFi";
static NSString * const YDNetworkStatusWWAN = @"WWAN";
static NSString * const YDNetworkStatus2G = @"2G";
static NSString * const YDNetworkStatus3G = @"3G";
static NSString * const YDNetworkStatus4G = @"4G";
static NSString * const YDNetworkStatusUnKnown = @"unknown";

@interface YDNetworkStatusMonitor()
@property (strong, nonatomic) NSString *currentNetworkStatus;
@property (strong, nonatomic) CTTelephonyNetworkInfo *networkInfo;
@end
@implementation YDNetworkStatusMonitor
+ (instancetype)sharedInstance
{
    static YDNetworkStatusMonitor *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       _networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNetworkChanged:) name:kORNetworkStatusChanged object:nil];
        [self refreshNetworkStatus];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshNetworkStatus
{
    AFNetworkReachabilityStatus afnetworkStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (afnetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        self.currentNetworkStatus = YDNetworkStatusNone;
    } else if (afnetworkStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
        self.currentNetworkStatus = YDNetworkStatusWiFi;
    } else if (afnetworkStatus == AFNetworkReachabilityStatusUnknown) {
        self.currentNetworkStatus = YDNetworkStatusUnKnown;
    } else if (afnetworkStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        NSString *currentStatus  = self.networkInfo.currentRadioAccessTechnology;
        if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]){
            self.currentNetworkStatus = YDNetworkStatus2G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]){
            self.currentNetworkStatus = YDNetworkStatus2G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
            self.currentNetworkStatus = YDNetworkStatus3G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
            self.currentNetworkStatus = YDNetworkStatus3G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
            self.currentNetworkStatus = YDNetworkStatus3G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
            self.currentNetworkStatus = YDNetworkStatus2G;
        } if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
            self.currentNetworkStatus = YDNetworkStatus3G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
            self.currentNetworkStatus = YDNetworkStatus3G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
            self.currentNetworkStatus = YDNetworkStatus3G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
            self.currentNetworkStatus = YDNetworkStatus3G;
        } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
            self.currentNetworkStatus = YDNetworkStatus4G;
        }
    }
}

- (void)onNetworkChanged:(id)aUserInfo
{
    [self refreshNetworkStatus];
}
@end

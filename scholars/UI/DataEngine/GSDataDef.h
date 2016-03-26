//
//  GSDataDef.h
//  dataModel
//
//  Created by r_zhou on 15/11/27.
//  Copyright © 2015年 r_zhou. All rights reserved.
//[]

#import <Foundation/Foundation.h>
#import "Jastor.h"

typedef NS_OPTIONS(NSInteger, YDHttpType) {
    YDHttpTypeGet = 0,
    YDHttpTypePost
};

@interface YDDataUserInfo : Jastor

@property (assign, nonatomic) int uid;
@property (strong, nonatomic) NSString *nickname;
@property (assign, nonatomic) int sex;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *photo;
@end


@interface YDNetworkDataUserInfo : Jastor

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *btype;
@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSString *catalog;
@end

@interface YDUserinfo :Jastor
@property (assign, nonatomic) int count;
@property (assign, nonatomic) int pagesize;
@property (strong, nonatomic) NSArray *rows;

@end


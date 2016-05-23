//
//  GSDataDef.h
//  dataModel
//
//  Created by r_zhou on 15/11/27.
//  Copyright © 2015年 r_zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "JSONModel.h"

typedef NS_OPTIONS(NSInteger, YDHttpType) {
    YDHttpTypeGet = 0,
    YDHttpTypePost
};


@interface SCBaseJsonModel : JSONModel

@end

/**
 *  获取列表返回结果基本类型
 */
@interface SCBasePageListResult : SCBaseJsonModel
/** 当前页码 */
@property (assign, nonatomic) int pageNo;
/** 每页记录数 */
@property (assign, nonatomic) int pageSize;
/** 总记录数 */
@property (assign, nonatomic) int count;
@end


// 分页 例子
@protocol SCPictureInfo

@end

@interface SCPictureInfo : SCBaseJsonModel

@property (copy, nonatomic) NSString *userid;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *photos;

@property (strong, nonatomic) NSArray *photosArray;
/*  分享链接  */
@property (copy, nonatomic) NSString *shareurl;
/*  分享缩略图  */
@property (copy, nonatomic) NSString *sharethumbnail;
/*  赞数  */
@property (assign, nonatomic) NSInteger lovecount;
/*  赞状态  */
@property (assign, nonatomic) NSInteger lovestatus;
/*  留言数  */
@property (assign, nonatomic) NSInteger messagenumber;

@end

@interface SCPictureList :SCBasePageListResult
@property (strong, nonatomic) NSArray<SCPictureInfo> *rows;
@end




/*  新闻  */
@protocol SCNewsInfo

@end

@interface SCNewsInfo : SCBaseJsonModel

@property (copy, nonatomic) NSString *objid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *photos;
@property (copy, nonatomic) NSString *publishTime;
/*  数据来源  */
@property (copy, nonatomic) NSString *source;
/*  分享链接  */
@property (copy, nonatomic) NSString *shareurl;
@end

@interface SCNewsList :SCBasePageListResult
@property (strong, nonatomic) NSArray<SCNewsInfo> *rows;
@end


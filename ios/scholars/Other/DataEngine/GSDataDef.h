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

/**
 *  系统消息跳转类型
 */
typedef NS_OPTIONS(NSInteger, YDRedirectActionType){
    /**
     *  跳到趣味  */
    YDRedirectActionTypePicture = 0,
    /**
     *  跳到聊天页面
     */
    YDRedirectActionTypeMessage
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

/**
 *  获取首页热门数据
 */
@protocol SCHomePageInfo

@end

@interface SCHomePageInfo : SCBaseJsonModel
/** keyID */
@property (assign, nonatomic) int keyID;
/** 标题 */
@property (copy, nonatomic) NSString *title;
/** 内容 */
@property (copy, nonatomic) NSString *content;
/** 图片 */
@property (copy, nonatomic) NSString *imageUrl;
@end

@interface RSHomePageList : SCBaseJsonModel
/** bannar图 **/
@property (strong, nonatomic) NSArray <SCHomePageInfo> *headUrlList;
/** 列表数据 **/
@property (strong, nonatomic) NSArray <SCHomePageInfo> *homePageList;
@end



// 分页 例子
@protocol SCPictureInfo

@end

@interface SCPictureInfo : SCBaseJsonModel

@property (assign, nonatomic) NSInteger photoID;
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
@property (strong, nonatomic) NSArray<SCPictureInfo> *photoList;
@end




/*  新闻  */
@protocol SCNewsInfo

@end

@interface SCNewsInfo : SCBaseJsonModel

@property (copy, nonatomic) NSString *newsID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *photos;
/*  数据来源  */
@property (copy, nonatomic) NSString *source;
/*  分享链接  */
@property (copy, nonatomic) NSString *shareurl;
@end

@interface SCNewsList :SCBasePageListResult
@property (strong, nonatomic) NSArray<SCNewsInfo> *newsList;
@end


/*  视频  */
@protocol SCVideoDataInfo

@end

@interface SCVideoDataInfo : SCBaseJsonModel
/*  objid  */
@property (copy, nonatomic) NSString *videoID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *photos;
/*  视频时长  */
@property (copy, nonatomic) NSString *duration;
/*  视频  */
@property (copy, nonatomic) NSString *vediourl;
@end

@interface SCVideoDataList :SCBasePageListResult
@property (strong, nonatomic) NSArray<SCVideoDataInfo> *videoList;
@end

@interface YDRedirectActionInfo : NSObject
@property (assign, nonatomic) YDRedirectActionType actionType;
@property (strong, nonatomic) id extraInfo;
@end

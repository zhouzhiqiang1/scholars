//
//  GSUrlDef.h
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/26.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//
#ifndef GlassStore_GSUrlDef_h
#define GlassStore_GSUrlDef_h

//pch 文件中修改地址
#ifdef DEVSERVER
#define GSHttpServer @"http://localhost:8080/"
#elif defined TESTSERVER
#define GSHttpServer @"http://192.168.1.225:8080/"

#else
#define GSHttpServer @"http://localhost:8080/"
#endif


//从缓存读取URL 假数据
static NSString * const GSUrlFalseDataInfo = @"";

//从缓存读取URL请求头Id
static NSString * const kURLRequestHeaderIdReadFromCache = @"CustomHeaderReadFromCache";

/**
 *  获取他人用户中心资料
 */
#define GSUrlOtherUserInfo [NSString stringWithFormat:@"%@api/works/bannerinfo/selectbannerinfo", GSHttpServer]

/**
 *  获取他人用户中心资料
 */
#define GSUrlCeShi [NSString stringWithFormat:@"%@index/home.json",GSHttpServer]

/**
 *  首页热门
 */
#define GSUrlHomePage [NSString stringWithFormat:@"%@index/api/home/homepagedata",GSHttpServer]

/**
 *  首页新闻
 */
#define GSUrlGetNews [NSString stringWithFormat:@"%@index/api/home/getNewsData",GSHttpServer]

/**
 *  首页视频
 */
#define GSUrlGetVideo [NSString stringWithFormat:@"%@index/api/home/getVideoData",GSHttpServer]

/**
 *  趣味图片
 */
#define GSUrlGetFunPhoto [NSString stringWithFormat:@"%@index/api/picture/getPhotoData",GSHttpServer]

/**
 *  趣味图片 1喜欢/0不喜欢
 */
#define GSUrlUpdatePhotoLoveStatus [NSString stringWithFormat:@"%@index/api/picture/updatePhotoData",GSHttpServer]
#endif

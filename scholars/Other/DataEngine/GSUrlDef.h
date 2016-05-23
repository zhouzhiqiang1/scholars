//
//  GSUrlDef.h
//  scholars
//
//  Created by r_zhou on 16/3/26.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//
#ifndef GlassStore_GSUrlDef_h
#define GlassStore_GSUrlDef_h

//pch 文件中修改地址
#ifdef DEVSERVER
#define GSHttpServer @"http://218.108.65.211/"
//#define GSHttpServer @"http://192.168.0.119:8080/"
#elif defined TESTSERVER
#define GSHttpServer @"http://test.readyidu.com/"

#else
#define GSHttpServer @"https://api.readyidu.com/"
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
 *  新闻
 */


#endif
//
//  GSErrorDef.h
//  GlassStore
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GSHTTPErrorDomain @"com.oread.oreadapp.http"
typedef enum  {
    GSErrorUrsInvalid = 400,
    GSErrorUrsUrlError = 401,
    
    GSErrorServerError = 600,
    GSErrorServerUnderRepair = 603,
    
    GSErrorUrsPasswordError = 201,
    GSErrorUrsEmailAlreadyRegisteredError = 202,
    GSErrorUrsUserNotExist = 204,
    GSErrorLGUserInactive = 205,
    GSErrorLGUserLocked = 206,
    GSErrorLGUserFreezed = 207,
    GSErrorInvalidDevice = 210,
    
    // Book
    GSErrorBookNotExist = 303,
    GSErrorInvalidRevision = 305,
    GSErrorBookInvalidTransferCode = 306,
    // 通用错误码Common
    GSErrorCMSuccess = 200,
    GSErrorCMInvalidToken = 220,
    GSErrorCMNoUpdate = 304,
    GSErrorCMFail = 500,
    GSErrorCMUnLogin = 501,
    GSErrorCMUnRegister = 502,
    GSErrorCMDidRegister = 503,
    GSErrorCMPasswordMistake = 504,
    GSErrorCMPasswordIllegal = 505,
    GSErrorCMInsufficientFunds = 506,
    GSErrorCMAccountFrozen = 507,
    GSErrorCMRegisterNotFinished = 508,
    GSErrorCMParamError = 509,
    
    GSErrorCMNetworkError = -1004,
}GSErrorCode;

#define ORHTTPErrorDomainSina @"open.weibo.cn"
typedef enum  {
    GSErrorSinaTokenUsed = 21314,
    GSErrorSinaTokenExpired = 21315,
    GSErrorSinaTokenRevoked = 21316,
    GSErrorSinaTokenRejected = 21317,
    GSErrorSinaTokenExpired2 = 21327,
    GSErrorSinaTokenInvalid = 21332
}GSErrorCodeSina;


NSString* GSErrorGetDescription(GSErrorCode aErrCode);
NSString* GSErrorSystemGetDescription(NSInteger aErrCode);

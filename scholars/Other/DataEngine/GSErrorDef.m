//
//  ORErrorDef.m
//  GlassStore
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSErrorDef.h"

NSString* GSErrorGetDescription(GSErrorCode aErrCode)
{
    switch (aErrCode)
    {
            //        case LDErrorCMSuccess:
            //            return @"成功";
            
        case GSErrorCMUnLogin:
            return @"未登录";
            
        case GSErrorCMUnRegister:
            return @"该帐号未注册";
            
        case GSErrorCMDidRegister:
            return @"已注册";
            
        case GSErrorCMPasswordMistake:
            return @"密码错误";
            
            //        case LDErrorCMPasswordIllegal:
            //            return @"密码不合法";
            
        case GSErrorCMInsufficientFunds:
            return @"余额不足";
            
            //        case LDErrorCMAccountFrozen:
            //            return @"你的帐号已被系统冻结\n如需解除，请联系客服\n电话：020-83568090 拨 2";
            
        case GSErrorCMRegisterNotFinished:
            return @"注册未完成";
            
            //        case LDErrorCMRegisterSexMissing:
            //            return @"缺少性别数据";
            
        case GSErrorCMParamError:
            return @"请求参数错误";
            
        case GSErrorUrsPasswordError:
            return NSLocalizedString(@"User name or password error!", nil);
        case GSErrorLGUserLocked:
            return NSLocalizedString(@"User locked!", nil);
        case GSErrorLGUserFreezed:
            return NSLocalizedString(@"User freezed!", nil);
        case GSErrorCMNetworkError:
            return NSLocalizedString(@"No network", nil);
        case GSErrorUrsEmailAlreadyRegisteredError:
            return NSLocalizedString(@"Email already registered", nil);
        case GSErrorInvalidDevice:
            return NSLocalizedString(@"Invliad device", nil);
        case GSErrorBookNotExist:
            return NSLocalizedString(@"Book not exist", nil);
        case GSErrorBookInvalidTransferCode:
            return NSLocalizedString(@"Invalid transfer code", nil);
        case GSErrorCMFail:
            return NSLocalizedString(@"Server error", nil);
        case GSErrorInvalidRevision:
            return NSLocalizedString(@"Revision error", nil);
            
        default:
            return nil;
    }
}

NSString* GSErrorSystemGetDescription(NSInteger aErrCode)
{
    switch (aErrCode)
    {
        case NSURLErrorTimedOut:
        case NSURLErrorNotConnectedToInternet:
            return NSLocalizedString(@"No network", nil);
        case GSErrorCMNetworkError:
            return NSLocalizedString(@"No network", nil);
        default:
            return [NSString stringWithFormat:NSLocalizedString(@"Error:%ld", nil), (long)aErrCode];
    }
}

//
//  ORQRCodeUtil.h
//  ORead
//
//  Created by noname on 15/2/9.
//  Copyright (c) 2015年 oread. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ORQRCodeUtil : NSObject

+(UIImage *)QRCodeImageFromString:(NSString *)aString;

+(NSString *)stringFromQRCodeImage:(UIImage *)aImage;

#pragma mark- 震动、声音效果

//+(BOOL)silenced;
/**
 @brief  识别成功震动提醒
 */
+ (void)systemVibrate;

/**
 @brief  扫码成功声音提醒
 */
+ (void)systemSound;
@end

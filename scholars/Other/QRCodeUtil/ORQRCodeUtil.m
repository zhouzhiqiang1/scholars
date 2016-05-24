//
//  ORQRCodeUtil.m
//  ORead
//
//  Created by noname on 15/2/9.
//  Copyright (c) 2015年 oread. All rights reserved.
//

#import "ORQRCodeUtil.h"
#import <Photos/Photos.h>

@implementation ORQRCodeUtil

+(UIImage *)QRCodeImageFromString:(NSString *)aString
{
    if (!aString) {
        return nil;
    }
    CIImage *ciImg = [ORQRCodeUtil createQRForString:aString];
    UIImage *resultImg = [ORQRCodeUtil createNonInterpolatedUIImageFromCIImage:ciImg withScale:2*[[UIScreen mainScreen] scale]];
    return resultImg;
}

+(NSString *)stringFromQRCodeImage:(UIImage *)aImage
{
    if (!aImage) {
        return nil;
    }
//    if ([ORAppUtil systemVersion].floatValue >= 8.0f)
//    {
//        CIDetector *qrcodeDetector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
//        CIImage *ciimg = [CIImage imageWithCGImage:aImage.CGImage];
//        NSArray *features = [qrcodeDetector featuresInImage:ciimg];
//        if (features.count>0) {
//            CIQRCodeFeature *qrcodeFeature = [features firstObject];
//            NSString *url = qrcodeFeature.messageString;
//            return url;
//        }
//    }

    return nil;
}

+(CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"L" forKey:@"inputCorrectionLevel"];
    
    // Send the image back
    return qrFilter.outputImage;
}

+(UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withScale:(CGFloat)scale
{
    // Render the CIImage into a CGImage
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    
    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width * scale, image.extent.size.width * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixel-correct image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    // Need to set the image orientation correctly
    UIImage *flippedImage = [UIImage imageWithCGImage:[scaledImage CGImage]
                                                scale:scaledImage.scale
                                          orientation:UIImageOrientationDownMirrored];
    
    return flippedImage;
}


#pragma mark- 震动、声音效果



#define SOUNDID  1109  //1012 -iphone   1152 ipad  1109 ipad
+ (void)systemVibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)systemSound
{
    AudioServicesPlaySystemSound(SOUNDID);
}
@end


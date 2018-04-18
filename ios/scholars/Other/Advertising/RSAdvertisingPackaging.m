//
//  RSAdvertisingPackaging.m
//  scholars
//
//  Created by R_zhou on 2018/4/9.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "RSAdvertisingPackaging.h"
#import "RSAdvertisingView.h"

@implementation RSAdvertisingPackaging

+ (instancetype)advertising
{
    static RSAdvertisingPackaging *_advertising = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _advertising = [[[self class] alloc] init];
    });
    return _advertising;
}

/**
 *  设置启动页广告
 */
- (void)setupAdvert {
    
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) { // 图片存在
        RSAdvertisingView *advertView = [[RSAdvertisingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        advertView.filePath = filePath;
        [advertView show];
    }
    
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAdvertisingImage];
}


/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage {
    
    // TODO 请求广告接口
    // 这里原本应该采用广告接口，现在用一些固定的网络图片url代替
    NSArray *imageArray = @[
                            @"http://7xk3oj.com2.z0.glb.qiniucdn.com/77FD11DFAA1D39015BFA034CD8271F79",
                            @"http://7xk3oj.com2.z0.glb.qiniucdn.com/3EE56EF95902F006044009039CCDC2C1",
                            @"http://a.hiphotos.baidu.com/image/pic/item/f9dcd100baa1cd11daf25f19bc12c8fcc3ce2d46.jpg"
                            ];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){ // 如果该图片不存在，则删除老图片，下载新图片
        
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
            
            
            
        }else{
            NSLog(@"保存失败");
        }
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage {
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    
    return nil;
}
@end

//
//  UIDevice(Identifier).m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"
#import "NSString+MD5Addition.h"
#import "Keychain.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#define kUUIDKeyInKeychain    @"kUUIDKeyInKeychain"

@interface UIDevice(Private)

- (NSString *) macaddress;

@end

@implementation UIDevice (IdentifierAddition)

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *)uuid
{
    //return @"02:00:00:00:00:00";

    NSString *uuid = [Keychain getStringForKey:kUUIDKeyInKeychain];
    if (uuid == nil)
    {
        CFUUIDRef uuidObj = CFUUIDCreate(nil);  //create a new UUID
        CFStringRef uuidRef = CFUUIDCreateString(nil, uuidObj);
        
        uuid = (__bridge NSString*)uuidRef;
        
        CFRelease(uuidObj);
        CFRelease(uuidRef);

        [Keychain saveString:uuid forKey:kUUIDKeyInKeychain];
    }
    
    return uuid;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods

+ (NSString *) uniqueDeviceIdentifier
{
    static NSString *uniqueIdentifier = nil;
    if (uniqueIdentifier == nil)
    {
        NSString *uuid = [[UIDevice currentDevice] uuid];
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

        NSString *stringToHash = [[NSString stringWithFormat:@"%@%@",uuid,bundleIdentifier] uppercaseString];
        uniqueIdentifier = [[stringToHash stringFromMD5] uppercaseString];
    }
    
    return [uniqueIdentifier lowercaseString];
}

+ (NSString *) uniqueGlobalDeviceIdentifier{
    NSString *uuid = [[UIDevice currentDevice] uuid];
    NSString *uniqueIdentifier = [uuid stringFromMD5];
    
    return [uniqueIdentifier lowercaseString];
}

+ (NSString *)uniqueRandomString
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);  //create a new UUID
    CFStringRef uuidRef = CFUUIDCreateString(nil, uuidObj);
    NSString *uniqueStr = (__bridge NSString*)uuidRef;
    CFRelease(uuidObj);
    CFRelease(uuidRef);
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *stringToHash = [[NSString stringWithFormat:@"%@%@",uniqueStr, bundleIdentifier] uppercaseString];
    NSString *uniqueIdentifier = [[stringToHash stringFromMD5] uppercaseString];
    return uniqueIdentifier;
}

@end

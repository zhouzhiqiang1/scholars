//
// Keychain.h
//
// Based on code by Michael Mayo at http://overhrd.com/?p=208
//
// Created by Frank Kim on 1/3/11.
//

#import "Keychain.h"
#import <Security/Security.h>

@implementation Keychain

+ (void)saveString:(NSString *)inputString forKey:(NSString	*)account {
	NSAssert(account != nil, @"Invalid account");
	NSAssert(inputString != nil, @"Invalid string");
	
	NSMutableDictionary *query = [NSMutableDictionary dictionary];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:account forKey:(id)kSecAttrAccount];
	[query setObject:(id)kSecAttrAccessibleWhenUnlocked forKey:(id)kSecAttrAccessible];
	
	OSStatus error = SecItemCopyMatching((CFDictionaryRef)query, NULL);
	if (error == errSecSuccess) {
		// do update
		NSDictionary *attributesToUpdate = [NSDictionary dictionaryWithObject:[inputString dataUsingEncoding:NSUTF8StringEncoding] 
																	  forKey:(id)kSecValueData];
		
		error = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef)attributesToUpdate);
		NSAssert1(error == errSecSuccess, @"SecItemUpdate failed: %ld", error);
	} else if (error == errSecItemNotFound) {
		// do add
		[query setObject:[inputString dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecValueData];
		
		error = SecItemAdd((CFDictionaryRef)query, NULL);
		NSAssert1(error == errSecSuccess, @"SecItemAdd failed: %ld", error);
	} else {
		NSAssert1(NO, @"SecItemCopyMatching failed: %ld", error);
	}
}

+ (NSString *)getStringForKey:(NSString *)account {
	NSAssert(account != nil, @"Invalid account");
	
	NSMutableDictionary *query = [NSMutableDictionary dictionary];

	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:account forKey:(id)kSecAttrAccount];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];

	NSData *dataFromKeychain = nil;

	OSStatus error = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&dataFromKeychain);
	
	NSString *stringToReturn = nil;
	if (error == errSecSuccess) {
		stringToReturn = [[[NSString alloc] initWithData:dataFromKeychain encoding:NSUTF8StringEncoding] autorelease];
	}
	
	[dataFromKeychain release];
	
	return stringToReturn;
}

+ (void)deleteStringForKey:(NSString *)account {
	NSAssert(account != nil, @"Invalid account");

	NSMutableDictionary *query = [NSMutableDictionary dictionary];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:account forKey:(id)kSecAttrAccount];
		
	OSStatus status = SecItemDelete((CFDictionaryRef)query);
	if (status != errSecSuccess) {
		NSLog(@"SecItemDelete failed: %d", (int)status);
	}
}

@end
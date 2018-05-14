//
//  RSTableDelegate.m
//  scholars
//
//  Created by R_zhou on 2018/4/19.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "RSTableDelegate.h"
#import "RSDataSource.h"

@interface RSTableDelegate ()
@property (strong, nonatomic) RSDataSource *datasource;
@end

@implementation RSTableDelegate
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if([super respondsToSelector:aSelector]) {
        return self;
    } else if ([self.viewController respondsToSelector:aSelector]) {
        return self.viewController;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [self.viewController respondsToSelector:aSelector];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    const char * classCString = object_getClassName(self.viewController);
    NSString *className = [NSString stringWithCString:classCString encoding:NSUTF8StringEncoding];
    SEL selector = NSSelectorFromString(@"tableView:heightForRowAtIndexPath:");
    NSString *str = [NSString stringWithFormat:@"%@必须实现tableView:heightForRowAtIndexPath:方法",className];
    //respondsToSelector 判读实例是否有这样方法
    NSAssert([self.viewController respondsToSelector:selector], str);
    
    if([self respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
      return [self.viewController tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    const char * classCString = object_getClassName(self.viewController);
    NSString *className = [NSString stringWithCString:classCString encoding:NSUTF8StringEncoding];
    SEL selector = NSSelectorFromString(@"tableView:didSelectRowAtIndexPath:");
    NSString *str = [NSString stringWithFormat:@"%@必须实现tableView:didSelectRowAtIndexPath:方法",className];
    //respondsToSelector 判读实例是否有这样方法
    NSAssert([self.viewController respondsToSelector:selector], str);
    
    if([self respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.viewController tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end

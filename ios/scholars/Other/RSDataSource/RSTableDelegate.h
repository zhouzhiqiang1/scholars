//
//  RSTableDelegate.h
//  scholars
//
//  Created by R_zhou on 2018/4/19.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSTableDelegate : NSObject <UITableViewDelegate>
@property (nonatomic, weak) IBOutlet id <UITableViewDelegate>viewController;
@end

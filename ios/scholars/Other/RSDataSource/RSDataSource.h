//
//  RSDataSource.h
//  MenuDemo
//
//  Created by R_zhou on 2018/4/16.
//  Copyright © 2018年 R_zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCellConfigure.h"

typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);

@interface RSDataSource : NSObject <UITableViewDataSource>

//--------- For Code
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before;

//--------- For StoryBoard
@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;

@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;


//---------Public

- (void)addModels:(id)models;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

@end


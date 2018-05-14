//
//  RSDataSource.m
//  MenuDemo
//
//  Created by R_zhou on 2018/4/16.
//  Copyright © 2018年 R_zhou. All rights reserved.
//

#import "RSDataSource.h"
#import <objc/runtime.h>

@interface RSDataSource (){
    NSMutableArray *m_Models;
}
@end

@implementation RSDataSource
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before {
    if(self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
    }
    return self;
}

- (void)addModels:(id)models {
    if(!models) return;
    m_Models = models;
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return m_Models.count > indexPath.row ? [m_Models objectAtIndex:indexPath.row] : nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_Models == nil ? 0: m_Models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    if ([cell respondsToSelector:@selector(configureCellWithModel:)]) {
        [cell performSelector:@selector(configureCellWithModel:) withObject:model];
    }
    
    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return m_Models == nil ? 0: m_Models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    if ([cell respondsToSelector:@selector(configureCellWithModel:)]) {
        [cell performSelector:@selector(configureCellWithModel:) withObject:model];
    }
    return cell;
}


@end


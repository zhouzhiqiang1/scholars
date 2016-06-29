//
//  SCWorkListViewController.m
//  scholars
//
//  Created by r_zhou on 16/5/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SCWorkListViewController.h"
#import "SCWorkListCollectionViewCell.h"

@interface SCWorkListViewController ()

@end

@implementation SCWorkListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger row = indexPath.row;
    
    static NSString *tribalCellIdentifier = @"SCWorkListCollectionViewCell";
    
    
    SCWorkListCollectionViewCell *workListCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:tribalCellIdentifier forIndexPath:indexPath];

    
    
    return workListCollectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isVideoLayout) {
        return CGSizeMake(self.view.frame.size.width / 2 - 10, self.view.frame.size.width / 2);
    } else {
        return CGSizeMake(self.view.frame.size.width, 200);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{   if (_isVideoLayout) {
    return UIEdgeInsetsMake(5, 5, 5, 5);
    } else {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsZero;
}


//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//定义每个UICollectionView 横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}




@end

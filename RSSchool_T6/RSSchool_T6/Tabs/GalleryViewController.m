//
//  GalleryViewController.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "GalleryViewController.h"
#import "PHAssetCollectionCell.h"
#import "PreviewPHAssetViewController.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:PHAssetCollectionCell.class forCellWithReuseIdentifier:@"PHAssetCollectionCellId"];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized:
                    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
                    [self getItemsFromGallery];
                    [self.collectionView reloadData];
                    break;
                default:
                    [self showNoPhotoAccessAlert];
                    break;
            }
        });
    }];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PHAssetCollectionCellId" forIndexPath:indexPath];
    [cell setupCellWith:[self.phFetchResult objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.phFetchResult count];
}

- (void)getItemsFromGallery {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    self.phFetchResult = [PHAsset fetchAssetsWithOptions:options];
}

- (void)viewDidDisappear:(BOOL)animated {
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
    }
    
    [super viewDidDisappear:animated];
}

- (void)showNoPhotoAccessAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No photo access" message:@"Please grant photo access in Settings -> Privacy" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:alertAction];
    [self.navigationController presentViewController:alertController animated: YES completion: nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = [self.phFetchResult objectAtIndex:indexPath.row];
    
    PreviewPHAssetViewController *previewVC = [PreviewPHAssetViewController new];
    previewVC.phAsset = asset;
    previewVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:previewVC animated:YES completion:nil];
}

@end

//MARK: - CollectionViewDelegateFlowLayout
@implementation GalleryViewController (CollectionViewDelegateFlowLayout)

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.collectionView.bounds.size.width-20)/3, (self.collectionView.bounds.size.width-20)/3);
}

@end

//MARK: - PhotoLibraryChangeObserver
@implementation GalleryViewController (PhotoLibraryChangeObserver)

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getItemsFromGallery];
        [self.collectionView reloadData];
    });
}

@end



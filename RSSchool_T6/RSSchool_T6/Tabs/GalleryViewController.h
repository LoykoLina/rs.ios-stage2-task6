//
//  GalleryViewController.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryViewController : UICollectionViewController

@property (nonatomic, strong) PHFetchResult *phFetchResult;

@end

@interface GalleryViewController (CollectionViewDelegateFlowLayout) <UICollectionViewDelegateFlowLayout>

@end

@interface GalleryViewController (PhotoLibraryChangeObserver) <PHPhotoLibraryChangeObserver>

@end

NS_ASSUME_NONNULL_END

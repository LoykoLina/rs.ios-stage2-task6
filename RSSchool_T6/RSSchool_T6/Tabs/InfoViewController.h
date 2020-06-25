//
//  InfoViewController.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoViewController : UITableViewController

@property (nonatomic, strong) PHFetchResult *fetchResult;

@end

@interface InfoViewController (CollectionViewDelegate) <UICollectionViewDelegate>

@end

@interface InfoViewController (PhotoLibraryChangeObserver) <PHPhotoLibraryChangeObserver>

@end

NS_ASSUME_NONNULL_END

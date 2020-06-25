//
//  PreviewViewController.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/25/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;

NS_ASSUME_NONNULL_BEGIN

@interface PreviewPHAssetViewController : UIViewController

@property (nonatomic, strong) PHAsset *phAsset;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END

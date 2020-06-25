//
//  DetailsViewController.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/24/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PHAsset;

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) PHAsset *phAsset;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

NS_ASSUME_NONNULL_END

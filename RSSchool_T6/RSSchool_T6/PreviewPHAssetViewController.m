//
//  PreviewViewController.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/25/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "PreviewPHAssetViewController.h"
#import <Photos/Photos.h>
#import "UIColor+RSAppColors.h"

@interface PreviewPHAssetViewController ()

@end

@implementation PreviewPHAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor RSWhite];
    [self setupDoneButton];
    
    switch (self.phAsset.mediaType) {
        case PHAssetMediaTypeVideo:
            //AVPlayer
            break;
        case PHAssetMediaTypeImage:
        case PHAssetMediaTypeAudio:
        case PHAssetMediaTypeUnknown:
            [self setupImageView];
            break;
    }
}

- (void)pressedDone:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupDoneButton {
    self.doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.doneButton];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(pressedDone:) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 11.0, *)) {
        [self.doneButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:5].active = YES;
    } else {
        [self.doneButton.topAnchor constraintEqualToAnchor:self.topLayoutGuide.topAnchor constant:5].active = YES;
    }
    [self.doneButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15].active = YES;
}

- (void)setupImageView {
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [[PHImageManager defaultManager] requestImageForAsset:self.phAsset
                                               targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:options
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.layer.masksToBounds = NO;
        self.imageView.image = result;
    }];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
    ]];
}

@end

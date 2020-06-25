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
#import <AVFoundation/AVFoundation.h>

@interface PreviewPHAssetViewController ()

@end

static CGFloat const kButtonHeight = 10;
static CGFloat const kEdjeInsets = 5;

@implementation PreviewPHAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor RSWhite];
    [self setupDoneButton];
    
    switch (self.phAsset.mediaType) {
        case PHAssetMediaTypeVideo:
            [self setupAVPlayer];
            break;
        case PHAssetMediaTypeImage:
            [self setupImageView];
            [self setImageForMediaTypeImage];
            break;
        case PHAssetMediaTypeAudio:
            [self setupAVPlayer];
            [self setupImageView];
            self.imageView.image = [UIImage imageNamed:@"audio_image"];
            break;
        case PHAssetMediaTypeUnknown:
            [self setupImageView];
            self.imageView.image = [UIImage imageNamed:@"other_image"];
            break;
    }
}

- (void)pressedDone:(UIButton*)sender {
    if (self.avPlayer != nil) {
        [self.avPlayer pause];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupDoneButton {
    self.doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.doneButton];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(pressedDone:) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 11.0, *)) {
        [self.doneButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:kEdjeInsets].active = YES;
    } else {
        [self.doneButton.topAnchor constraintEqualToAnchor:self.topLayoutGuide.topAnchor constant:kEdjeInsets].active = YES;
    }
    [self.doneButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kEdjeInsets].active = YES;
    [self.doneButton.heightAnchor constraintEqualToConstant:kButtonHeight].active = YES;
}

- (void)setupImageView {
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.masksToBounds = NO;
    [self.view addSubview:self.imageView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.imageView.widthAnchor constraintEqualToConstant:self.view.bounds.size.width-2*kEdjeInsets],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-kEdjeInsets]
    ]];
    if (@available(iOS 11.0, *)) {
        [self.doneButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor
                                                  constant:2 * kEdjeInsets + kButtonHeight].active = YES;
    } else {
        [self.doneButton.topAnchor constraintEqualToAnchor:self.topLayoutGuide.topAnchor
                                                  constant:2 * kEdjeInsets + kButtonHeight].active = YES;
    }
}

- (void)setImageForMediaTypeImage {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [[PHImageManager defaultManager] requestImageForAsset:self.phAsset
                                               targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:options
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.imageView.image = result;
    }];
}

- (void)setupAVPlayer {
    [[PHImageManager defaultManager] requestPlayerItemForVideo:self.phAsset
                                                       options:nil
                                                 resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        playerLayer.frame = CGRectMake(kEdjeInsets,
                                       kButtonHeight + 2 * kEdjeInsets,
                                       self.view.bounds.size.width - 2 * kEdjeInsets,
                                       self.view.bounds.size.height - 3 * kEdjeInsets - kButtonHeight);
        [self.view.layer addSublayer:playerLayer];
        [self.avPlayer play];
    }];
}

@end

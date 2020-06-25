//
//  PHAssetCollectionCell.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/24/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "PHAssetCollectionCell.h"
#import <Photos/Photos.h>

@implementation PHAssetCollectionCell

- (void)setupCellWith:(PHAsset*)asset {
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeVideo:
        case PHAssetMediaTypeImage: {
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:CGSizeMake(100, 100)
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:nil
                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                self.imageView.contentMode = UIViewContentModeScaleAspectFill;
                self.imageView.layer.masksToBounds = YES;
                self.imageView.image = result;
            }];
            break;
        }
        case PHAssetMediaTypeAudio:
            self.imageView.image = [UIImage imageNamed:@"audio_image"];
            break;
        case PHAssetMediaTypeUnknown:
            self.imageView.image = [UIImage imageNamed:@"other_image"];
            break;
    }
}

- (void)layoutSubviews {
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [self.imageView.widthAnchor constraintEqualToAnchor:self.contentView.heightAnchor]
    ]];
}

@end

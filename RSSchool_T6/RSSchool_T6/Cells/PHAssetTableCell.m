//
//  PHAssetCell.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/24/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "PHAssetTableCell.h"
#import <Photos/Photos.h>
#import "NSString+NSTimeInterval.h"
#import "UIColor+RSAppColors.h"

@implementation PHAssetTableCell

- (void)setupCellWith:(PHAsset*)asset {
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    self.itemImage = [UIImageView new];
    self.itemImage.contentMode = UIViewContentModeScaleAspectFill;
    self.itemImage.layer.masksToBounds = YES;
    
    self.fileName = [UILabel new];
    [self.fileName setText:[NSString stringWithString:[PHAssetResource assetResourcesForAsset:asset].firstObject.originalFilename]];
    [self.fileName setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]];
    [self.fileName setTextColor:[UIColor RSBlack]];
    
    self.fileDesription = [UILabel new];
    [self.fileDesription setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular]];
    [self.fileDesription setTextColor:[UIColor RSBlack]];
    
    self.typeImage = [UIImageView new];
    self.typeImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeVideo: {
            NSString *durationStr = [[NSString new] stringFromTimeInterval:asset.duration];
            [self.fileDesription setText:[NSString stringWithFormat:@"%lux%lu %@", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight,  durationStr]];
            self.typeImage.image = [UIImage imageNamed:@"video"];
            self.itemImage.image = [self getImageFromAsset:asset];
            break;
        }
        case PHAssetMediaTypeImage: {
            self.itemImage.image = [self getImageFromAsset:asset];
            [self.fileDesription setText:[NSString stringWithFormat:@"%lux%lu", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight]];
            self.typeImage.image = [UIImage imageNamed:@"image"];
            break;
        }
        case PHAssetMediaTypeAudio:
            [self.fileDesription setText:[NSString stringWithFormat:@"%f", asset.duration]];
            self.typeImage.image = [UIImage imageNamed:@"audio"];
            self.itemImage.image = [UIImage imageNamed:@"audio_image"];
            break;
        case PHAssetMediaTypeUnknown:
            [self.fileDesription setText:@""];
            self.typeImage.image = [UIImage imageNamed:@"other"];
            self.itemImage.image = [UIImage imageNamed:@"other_image"];
            break;
    }
    
    [self.contentView addSubview:self.itemImage];
    [self.contentView addSubview:self.fileName];
    [self.contentView addSubview:self.fileDesription];
    [self.contentView addSubview:self.typeImage];
}

- (void)layoutSubviews {
    self.itemImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileName.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileDesription.translatesAutoresizingMaskIntoConstraints = NO;
    self.typeImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.itemImage.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.itemImage.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5],
        [self.itemImage.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5],
        [self.itemImage.widthAnchor constraintEqualToAnchor:self.itemImage.heightAnchor],

        [self.fileName.leadingAnchor constraintEqualToAnchor:self.itemImage.trailingAnchor constant:10],
        [self.fileName.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10],
        [self.fileName.bottomAnchor constraintEqualToAnchor:self.centerYAnchor constant:-5],

        [self.typeImage.leadingAnchor constraintEqualToAnchor:self.fileName.leadingAnchor],
        [self.typeImage.topAnchor constraintEqualToAnchor:self.centerYAnchor constant:5],
        [self.typeImage.widthAnchor constraintEqualToAnchor:self.typeImage.heightAnchor],

        [self.fileDesription.leadingAnchor constraintEqualToAnchor:self.typeImage.trailingAnchor constant:5],
        [self.fileDesription.trailingAnchor constraintEqualToAnchor:self.fileName.trailingAnchor],
        [self.fileDesription.centerYAnchor constraintEqualToAnchor:self.typeImage.centerYAnchor]
    ]];
}

- (UIImage*)getImageFromAsset:(PHAsset*)asset {
    __block UIImage *image = [UIImage new];
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(200, 200)
                                              contentMode:PHImageContentModeAspectFill
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result;
    }];
    return image;
}

@end

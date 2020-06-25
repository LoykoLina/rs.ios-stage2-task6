//
//  PHAssetCell.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/24/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PHAsset;

@interface PHAssetTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *itemImage;
@property (nonatomic, strong) UIImageView *typeImage;
@property (nonatomic, strong) UILabel *fileName;
@property (nonatomic, strong) UILabel *fileDesription;

- (void)setupCellWith:(PHAsset*)asset;

@end

NS_ASSUME_NONNULL_END

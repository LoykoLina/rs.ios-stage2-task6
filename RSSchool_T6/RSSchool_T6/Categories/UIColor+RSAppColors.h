//
//  UIColor+RSAppColors.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/25/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (RSAppColors)

+ (UIColor*)getUIColorFromHex:(NSInteger)hexColor;
+ (UIColor*)RSBlack;
+ (UIColor*)RSWhite;
+ (UIColor*)RSRed;
+ (UIColor*)RSBlue;
+ (UIColor*)RSGreen;
+ (UIColor*)RSYellow;
+ (UIColor*)RSYellowHighlighted;
+ (UIColor*)RSGray;

@end

NS_ASSUME_NONNULL_END

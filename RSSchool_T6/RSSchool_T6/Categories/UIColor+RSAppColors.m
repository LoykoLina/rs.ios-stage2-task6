//
//  UIColor+RSAppColors.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/25/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "UIColor+RSAppColors.h"

@implementation UIColor (RSAppColors)

+ (UIColor*)getUIColorFromHex:(NSInteger)hexColor {
    return [UIColor colorWithRed:((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((hexColor & 0x00FF00) >> 8)) / 255.0
                            blue:((CGFloat)((hexColor & 0x0000FF) >> 0)) / 255.0
                           alpha:hexColor > 0xFFFFFF ? ((CGFloat)((hexColor >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1];
}

+ (UIColor*)RSBlack {
    return [UIColor getUIColorFromHex:0x101010];
}

+ (UIColor*)RSWhite {
    return [UIColor getUIColorFromHex:0xFFFFFF];
}

+ (UIColor*)RSRed {
    return [UIColor getUIColorFromHex:0xEE686A];
}

+ (UIColor*)RSBlue {
    return [UIColor getUIColorFromHex:0x29C2D1];
}

+ (UIColor*)RSGreen {
    return [UIColor getUIColorFromHex:0x34C1A1];
}

+ (UIColor*)RSYellow {
    return [UIColor getUIColorFromHex:0xF9CC78];
}

+ (UIColor*)RSYellowHighlighted {
    return [UIColor getUIColorFromHex:0xFDF4E3];
}

+ (UIColor*)RSGray {
    return [UIColor getUIColorFromHex:0x707070];
}

@end

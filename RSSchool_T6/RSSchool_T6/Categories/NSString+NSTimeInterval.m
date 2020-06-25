//
//  NSTimeInterval+StringConversion.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/25/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "NSString+NSTimeInterval.h"

@implementation NSString (NSTimeInterval)

- (NSString*)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger timeInterval = (NSInteger)interval;
    NSInteger seconds = timeInterval % 60;
    NSInteger minutes = (timeInterval / 60) % 60;
    NSInteger hours = (timeInterval / 3600);
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    }
    else {
        return [NSString stringWithFormat:@"%02li:%02li", (long)minutes, (long)seconds];
    }
}

@end

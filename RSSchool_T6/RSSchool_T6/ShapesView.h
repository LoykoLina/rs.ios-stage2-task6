//
//  ShapesStackView.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShapesView : UIView

@property (nonatomic, strong) UIView *triangle;
@property (nonatomic, strong) UIView *circle;
@property (nonatomic, strong) UIView *square;
@property (nonatomic, strong) UIStackView *shapesStackView;

- (void)animateShapes;
- (void)stopShapesAnimation;

@end

NS_ASSUME_NONNULL_END

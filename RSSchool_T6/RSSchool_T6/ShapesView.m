//
//  ShapesStackView.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "ShapesView.h"
#import "UIColor+RSAppColors.h"

static CGFloat const kShapeSize = 70;
static CGFloat const kStackViewSpacing = 42;

@implementation ShapesView

- (void)layoutSubviews {
    [self setShapeViewConstraints:self.circle];
    [self setShapeViewConstraints:self.square];
    [self setShapeViewConstraints:self.triangle];
    
    self.shapesStackView.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.shapesStackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.shapesStackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createShapesStackView];
    }
    return self;
}

- (void)createCircle {
    self.circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kShapeSize, kShapeSize)];
    self.circle.layer.cornerRadius = self.circle.frame.size.width / 2;
    self.circle.backgroundColor = [UIColor RSRed];
}

- (void)createSquare {
    self.square = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kShapeSize, kShapeSize)];
    self.square.backgroundColor = [UIColor RSBlue];
}

- (void)createTriangle {
    self.triangle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kShapeSize, kShapeSize)];
    self.triangle.backgroundColor = [UIColor RSGreen];
    
    UIBezierPath* trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(0, self.triangle.frame.size.height)];
    [trianglePath addLineToPoint:CGPointMake(self.triangle.frame.size.width / 2, 0)];
    [trianglePath addLineToPoint:CGPointMake(self.triangle.frame.size.width, self.triangle.frame.size.height)];
    [trianglePath closePath];
    
    CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
    [triangleMaskLayer setPath:trianglePath.CGPath];
    self.triangle.layer.mask = triangleMaskLayer;
}

- (void)setShapeViewConstraints:(UIView *)shapeView {
    shapeView.translatesAutoresizingMaskIntoConstraints = false;
    [shapeView.heightAnchor constraintEqualToConstant:kShapeSize].active = true;
    [shapeView.widthAnchor constraintEqualToConstant:kShapeSize].active = true;
}

- (void)createShapesStackView {
    self.shapesStackView = [[UIStackView alloc] init];
    self.shapesStackView.axis = UILayoutConstraintAxisHorizontal;
    self.shapesStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.shapesStackView.alignment = UIStackViewAlignmentCenter;
    self.shapesStackView.spacing = kStackViewSpacing;
    
    [self createSquare];
    [self createCircle];
    [self createTriangle];
    [self.shapesStackView addArrangedSubview:self.circle];
    [self.shapesStackView addArrangedSubview:self.square];
    [self.shapesStackView addArrangedSubview:self.triangle];
    [self addSubview:self.shapesStackView];
}

- (void)animatePulsingCircle {
    [UIView animateWithDuration:1.2 delay:0 options:(UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
        [self.circle setTransform:CGAffineTransformScale(self.circle.transform, 0.9, 0.9)];
        self.circle.transform = CGAffineTransformIdentity;
        [self.circle setTransform:CGAffineTransformScale(self.circle.transform, 1.1, 1.1)];
    } completion: ^(BOOL completed){
        [self animatePulsingCircle];
    }];
}

- (void)animateRotatingTriangle {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.triangle setTransform:CGAffineTransformRotate(self.triangle.transform, M_PI_4 / 2)];
    }completion: ^(BOOL completed){
        [self animateRotatingTriangle];
    }];
}

- (void)animateMovingSquare {
    CGFloat originY = self.square.layer.position.y;
    [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
        self.square.layer.position = CGPointMake(self.square.layer.position.x, originY - self.square.frame.size.width * 0.1);
        self.square.layer.position = CGPointMake(self.square.layer.position.x, originY);
        self.square.layer.position = CGPointMake(self.square.layer.position.x, originY + self.square.frame.size.width * 0.1);
    } completion: ^(BOOL completed){
        self.square.layer.position = CGPointMake(self.square.layer.position.x, originY);
        [self animateMovingSquare];
    }];
}

- (void)animateShapes {
    [self animatePulsingCircle];
    [self animateMovingSquare];
    [self animateRotatingTriangle];
}

- (void)stopShapesAnimation {
    [self.circle.layer removeAllAnimations];
    [self.triangle.layer removeAllAnimations];
    [self.square.layer removeAllAnimations];
}

@end

//
//  StartViewController.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/21/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShapesView;

@interface StartViewController : UIViewController

@property (nonatomic, strong) ShapesView *shapes;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *label;

- (void)createShapesView;
- (void)createLabel;
- (void)createStartButton;

@end

NS_ASSUME_NONNULL_END

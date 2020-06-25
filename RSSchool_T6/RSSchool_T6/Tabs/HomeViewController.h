//
//  RSSchoolTaskViewController.h
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShapesView;

@interface HomeViewController : UIViewController

@property (nonatomic, strong) UIButton *gitCVButton;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIImageView *appleLogo;
@property (nonatomic, strong) UILabel *phoneInfo;
@property (nonatomic, strong) ShapesView *shapes;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@end

NS_ASSUME_NONNULL_END

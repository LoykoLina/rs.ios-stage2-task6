//
//  StartViewController.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/21/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "StartViewController.h"
#import "TabBarController.h"
#import "ShapesView.h"
#import "UIColor+RSAppColors.h"

static CGFloat const kSpacing = 100;
static CGFloat const kButtonHeight = 55;
static CGFloat const kLabelFontSize = 24;
static CGFloat const kButtonFontSize = 20;
static CGFloat const kButtonCornerRadius = 30;
static CGFloat const kButtonCenterOffset = 170;

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor RSWhite];
    
    [self createShapesView];
    [self createLabel];
    [self createStartButton];
}

- (void)createShapesView {
    self.shapes = [[ShapesView alloc] init];
    [self.shapes layoutIfNeeded];
    [self.view addSubview:self.shapes];

    self.shapes.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.shapes.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.shapes.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-kSpacing]
    ]];
}

- (void)createLabel {
    self.label = [[UILabel alloc] init];
    [self.label setText:@"Are you ready?"];
    [self.view addSubview:self.label];
    [self.label setFont:[UIFont systemFontOfSize:kLabelFontSize weight:UIFontWeightMedium]];
    [self.label setTextColor:[UIColor RSBlack]];
    
    self.label.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.label.bottomAnchor constraintEqualToAnchor:self.shapes.topAnchor constant:-kSpacing]
    ]];
}

- (void)createStartButton {
    self.startButton = [[UIButton alloc] init];
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    [self.startButton.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
    [self.startButton setTitleColor:[UIColor RSBlack] forState:UIControlStateNormal];
    self.startButton.backgroundColor = [UIColor RSYellow];
    self.startButton.layer.cornerRadius = kButtonCornerRadius;
    [self.view addSubview:self.startButton];
    
    [self.startButton addTarget:self action:@selector(pressedStartButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.startButton.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.startButton.heightAnchor constraintEqualToConstant:kButtonHeight],
        [self.startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.startButton.leadingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.leadingAnchor],
        [self.startButton.trailingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.trailingAnchor],
        [self.startButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:kButtonCenterOffset]
    ]];
}

- (void)pressedStartButton:(UIButton *) sender {
    TabBarController *tabBarVC = [[TabBarController alloc] init];
    tabBarVC.modalPresentationStyle = UIModalPresentationFullScreen;
    tabBarVC.selectedIndex = 1;
    [self presentViewController:tabBarVC animated:true completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.shapes animateShapes];
}

@end

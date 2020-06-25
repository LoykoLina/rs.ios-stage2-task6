//
//  RSSchoolTaskViewController.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "HomeViewController.h"
#import "StartViewController.h"
#import "ShapesView.h"
#import "UIColor+RSAppColors.h"

static CGFloat const kButtonCornerRadius = 30;
static CGFloat const kButtonFontSize = 20;
static CGFloat const kButtonHeight = 55;

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createShapesView];
    [self createLines];
    [self createButtons];
    [self createImageView];
    [self createPhoneInfoLabel];
}

- (void)createPhoneInfoLabel {
    self.phoneInfo = [[UILabel alloc] init];
    [self.view addSubview:self.phoneInfo];
    [self.phoneInfo setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
    [self.phoneInfo setTextColor:[UIColor RSBlack]];
    self.phoneInfo.numberOfLines = 0;
    
    NSString *labelText = [NSString stringWithFormat:@"%@ \n%@ \n%@ %@",UIDevice.currentDevice.name, UIDevice.currentDevice.model, UIDevice.currentDevice.systemName, UIDevice.currentDevice.systemVersion];
    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:labelText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:12];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, labelText.length)];
    self.phoneInfo.attributedText = attrString;
    
    self.phoneInfo.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.phoneInfo.leadingAnchor constraintEqualToAnchor:self.appleLogo.trailingAnchor constant:40],
        [self.phoneInfo.topAnchor constraintEqualToAnchor:self.appleLogo.topAnchor constant:10]
    ]];
}

- (void)createImageView {
    self.appleLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple"]];
    [self.view addSubview:self.appleLogo];
    self.appleLogo.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.appleLogo.leadingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.leadingAnchor],
        [self.appleLogo.bottomAnchor constraintEqualToAnchor:self.topLine.topAnchor constant:-40]
    ]];
}


- (void)createButtons {
    self.startButton = [[UIButton alloc] init];
    [self.startButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    [self.startButton.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
    [self.startButton setTitleColor:[UIColor RSWhite] forState:UIControlStateNormal];
    self.startButton.backgroundColor = [UIColor RSRed];
    self.startButton.layer.cornerRadius = kButtonCornerRadius;
    [self.view addSubview:self.startButton];
    
    [self.startButton addTarget:self action:@selector(pressedStartButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.gitCVButton = [[UIButton alloc] init];
    [self.gitCVButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    [self.gitCVButton.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
    [self.gitCVButton setTitleColor:[UIColor RSBlack] forState:UIControlStateNormal];
    self.gitCVButton.backgroundColor = [UIColor RSYellow];
    self.gitCVButton.layer.cornerRadius = kButtonCornerRadius;
    [self.view addSubview:self.gitCVButton];
    
    [self.gitCVButton addTarget:self action:@selector(pressedGitCVButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.startButton.translatesAutoresizingMaskIntoConstraints = false;
    self.gitCVButton.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.gitCVButton.heightAnchor constraintEqualToConstant:kButtonHeight],
        [self.gitCVButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.gitCVButton.leadingAnchor constraintEqualToAnchor:self.startButton.leadingAnchor],
        [self.gitCVButton.trailingAnchor constraintEqualToAnchor:self.startButton.trailingAnchor],
        [self.gitCVButton.topAnchor constraintEqualToAnchor:self.bottomLine.bottomAnchor constant:40],
        
        [self.startButton.heightAnchor constraintEqualToConstant:kButtonHeight],
        [self.startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.startButton.leadingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.leadingAnchor],
        [self.startButton.trailingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.trailingAnchor],
        [self.startButton.topAnchor constraintEqualToAnchor:self.gitCVButton.bottomAnchor constant:20]
    ]];
}

- (void)pressedStartButton:(UIButton *) sender {
    StartViewController *startVC = [[StartViewController alloc] init];
    startVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:startVC animated:true completion:nil];
}

- (void)pressedGitCVButton:(UIButton *) sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://loykolina.github.io/rsschool-cv/cv"] options:@{} completionHandler:nil];
}

- (void)createShapesView {
    self.shapes = [[ShapesView alloc] init];
    [self.shapes layoutIfNeeded];
    [self.view addSubview:self.shapes];

    self.shapes.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.shapes.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.shapes.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0]
    ]];
}

- (void)createLines {
    self.topLine = [[UIView alloc] init];
    self.topLine.backgroundColor = [UIColor RSGray];
    [self.view addSubview:self.topLine];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = [UIColor RSGray];
    [self.view addSubview:self.bottomLine];
    
    self.topLine.translatesAutoresizingMaskIntoConstraints = false;
    self.bottomLine.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.topLine.heightAnchor constraintEqualToConstant:1],
        [self.topLine.leadingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.leadingAnchor],
        [self.topLine.trailingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.trailingAnchor],
        [self.topLine.bottomAnchor constraintEqualToAnchor:self.shapes.shapesStackView.topAnchor constant:-55],

        [self.bottomLine.heightAnchor constraintEqualToConstant:1],
        [self.bottomLine.leadingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.leadingAnchor],
        [self.bottomLine.trailingAnchor constraintEqualToAnchor:self.shapes.shapesStackView.trailingAnchor],
        [self.bottomLine.topAnchor constraintEqualToAnchor:self.shapes.shapesStackView.bottomAnchor constant:55]
    ]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.shapes animateShapes];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.shapes stopShapesAnimation];
    [super viewDidDisappear:animated];
}

@end

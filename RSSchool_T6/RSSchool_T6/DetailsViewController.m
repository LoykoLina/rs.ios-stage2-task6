//
//  DetailsViewController.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/24/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "DetailsViewController.h"
#import <Photos/Photos.h>
#import "UIColor+RSAppColors.h"

static CGFloat const kButtonFontSize = 20;
static CGFloat const kButtonCornerRadius = 30;
static CGFloat const kButtonHeight = 55;

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor RSWhite];
    self.navigationItem.title = [PHAssetResource assetResourcesForAsset:self.phAsset].firstObject.originalFilename;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"]
                                                                                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self.navigationController
                                                                            action:@selector(popViewControllerAnimated:)];
    
    [self createScrollView];
    [self createImageView];
    [self createLabel];
    if (self.phAsset.mediaType == PHAssetMediaTypeVideo || self.phAsset.mediaType == PHAssetMediaTypeImage) {
        [self createShareButton];
    }
}

- (void)createImageView {
    self.imageView = [UIImageView new];
    [self.contentView addSubview:self.imageView];
    
    switch (self.phAsset.mediaType) {
        case PHAssetMediaTypeVideo:        
        case PHAssetMediaTypeImage: {
            [[PHImageManager defaultManager] requestImageForAsset:self.phAsset
                                                       targetSize:CGSizeMake(self.view.frame.size.width-20, 100)
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:nil
                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                self.imageView.contentMode = UIViewContentModeScaleAspectFit ;
                self.imageView.layer.masksToBounds = NO;
                self.imageView.image = result;
            }];
            break;
        }
        case PHAssetMediaTypeAudio:
            self.imageView.image = [UIImage imageNamed:@"audio_image"];
            break;
        case PHAssetMediaTypeUnknown:
            self.imageView.image = [UIImage imageNamed:@"other_image"];
            break;
    }
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]
    ]];
}

- (void)createLabel {
    self.label = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.label];
    
    [self.label setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
    [self.label setTextColor:[UIColor RSBlack]];
    self.label.numberOfLines = 0;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"HH:mm:ss dd.mm.yyyy"];
    NSString *creationDate = [dateFormatter stringFromDate:self.phAsset.creationDate];
    NSString *modificationDate = [dateFormatter stringFromDate:self.phAsset.modificationDate];
    NSString *type = [NSString new];
    switch (self.phAsset.mediaType) {
        case PHAssetMediaTypeVideo:
            type = @"Video";
            break;
        case PHAssetMediaTypeAudio:
            type = @"Audio";
            break;
        case PHAssetMediaTypeImage:
            type = @"Image";
            break;
        case PHAssetMediaTypeUnknown:
            type = @"Other";
            break;
    }
    NSString *labelText = [NSString stringWithFormat:@"Creation date: %@ \nModification date: %@ \nType: %@ ", creationDate, modificationDate, type];
    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:labelText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:12];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, labelText.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor RSGray]
                       range:NSMakeRange(0, @"Creation date:".length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor RSGray]
                       range:NSMakeRange([labelText rangeOfString:@"M"].location, @"Modification date:".length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor RSGray]
                       range:NSMakeRange(labelText.length - 12, @"Type:".length)];
    self.label.attributedText = attrString;
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.label.leadingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor],
        [self.label.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor],
        [self.label.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:30]
    ]];
}

- (void)createShareButton {
    self.shareButton = [[UIButton alloc] init];
    [self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
    [self.shareButton.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
    [self.shareButton setTitleColor:[UIColor RSBlack] forState:UIControlStateNormal];
    self.shareButton.backgroundColor = [UIColor RSYellow];
    self.shareButton.layer.cornerRadius = kButtonCornerRadius;
   
    [self.contentView addSubview:self.shareButton];
    
    [self.shareButton addTarget:self action:@selector(pressedShareButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.shareButton.heightAnchor constraintEqualToConstant:kButtonHeight],
        [self.shareButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.shareButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.shareButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.shareButton.topAnchor constraintEqualToAnchor:self.label.bottomAnchor constant:30]
    ]];
}

- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc] initWithFrame:self.scrollView.frame];
    [self.scrollView addSubview:self.contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = false;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
        
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.widthAnchor constraintEqualToConstant:self.view.bounds.size.width-20]
    ]];
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10],
            [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10]
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.scrollView.bottomAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:-10],
            [self.scrollView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.topAnchor constant:10]
        ]];
    }
}


- (void)pressedShareButton:(UIButton*)sender {
    NSArray *activityItems = @[self.navigationItem.title, self.imageView.image];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self.navigationController presentViewController:activityViewControntroller animated:true completion:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    CGFloat newHeight;
    
    if (self.shareButton == nil) {
        newHeight = [self.label convertRect:self.label.bounds toView:self.contentView].origin.y + self.label.bounds.size.height + 20;
    } else {
        newHeight = [self.shareButton convertRect:self.shareButton.bounds toView:self.contentView].origin.y + self.shareButton.bounds.size.height + 20;
    }
    
    [self.contentView.heightAnchor constraintEqualToConstant:newHeight].active = YES;
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    [super viewDidAppear:animated];
}

@end

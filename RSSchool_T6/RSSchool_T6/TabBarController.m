//
//  TabBarViewController.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "TabBarController.h"
#import "Tabs/HomeViewController.h"
#import "Tabs/GalleryViewController.h"
#import "Tabs/InfoViewController.h"
#import "UIColor+RSAppColors.h"

static CGFloat const kTabImageOffset = 5;
static CGFloat const kBarTitleFontSize = 18;

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
    [self addViewControllers];
}

- (void)addViewControllers {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setupTabViewController:homeVC
                           title:@"RSSchool Task 6"
                           image:[UIImage imageNamed:@"home_unselected"]
                   selectedImage:[UIImage imageNamed:@"home_selected"]];
    
    GalleryViewController *galleryVC = [[GalleryViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    galleryVC.collectionView.backgroundColor = [UIColor RSWhite];
    [self setupTabViewController:galleryVC
                           title:@"Gallery"
                           image:[UIImage imageNamed:@"gallery_unselected"]
                   selectedImage:[UIImage imageNamed:@"gallery_selected"]];
    
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    [self setupTabViewController:infoVC
                           title:@"Info"
                           image:[UIImage imageNamed:@"info_unselected"]
                   selectedImage:[UIImage imageNamed:@"info_selected"]];
    
    self.viewControllers = @[[self embedInNavigationController:infoVC],
                             [self embedInNavigationController:galleryVC],
                             [self embedInNavigationController:homeVC]];
}

- (UINavigationController *)embedInNavigationController:(UIViewController*)vc {
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.title = vc.title;
    [nc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor RSBlack],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:kBarTitleFontSize weight:UIFontWeightSemibold]}];
    [nc.navigationBar setBarTintColor:[UIColor RSYellow]];
    
    return nc;
}

- (void)setupTabViewController:(UIViewController *)vc title:(NSString*)title image:()image selectedImage:()selectedImage{
    vc.title = title;
    vc.view.backgroundColor = [UIColor RSWhite];
    vc.tabBarItem = [[UITabBarItem alloc]
                         initWithTitle:nil
                         image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                         selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(kTabImageOffset, 0, -kTabImageOffset, 0);
}

@end

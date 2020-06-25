//
//  InfoViewController.m
//  RSSchool_T6
//
//  Created by Lina Loyko on 6/22/20.
//  Copyright © 2020 Lina Loyko. All rights reserved.
//

#import "InfoViewController.h"
#import "PHAssetTableCell.h"
#import "DetailsViewController.h"
#import "UIColor+RSAppColors.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:PHAssetTableCell.class forCellReuseIdentifier:@"PHAssetTableCellId"];
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
        [self getItemsFromGallery];
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PHAssetTableCellId" forIndexPath:indexPath];
    
    [cell setupCellWith:[self.fetchResult objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (void)getItemsFromGallery {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    self.fetchResult = [PHAsset fetchAssetsWithOptions:options];
}

- (void)viewDidDisappear:(BOOL)animated {
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
    }
    
    [super viewDidDisappear:animated];
}

- (void)reloadData {
    [self getItemsFromGallery];
    [self.tableView reloadData];
}

@end

//MARK: - CollectionViewDelegate
@implementation InfoViewController (CollectionViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.size.width, cell.bounds.size.height)];
    view.backgroundColor = [UIColor RSYellowHighlighted];
    cell.selectedBackgroundView = view;
    
    DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
    detailsVC.modalPresentationStyle = UIModalPresentationFullScreen;
    detailsVC.phAsset = [self.fetchResult objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].contentView.backgroundColor = [UIColor RSYellowHighlighted];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].contentView.backgroundColor = [UIColor RSWhite];
}

@end

//MARK: - PhotoLibraryChangeObserver
@implementation InfoViewController (PhotoLibraryChangeObserver)

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getItemsFromGallery];
        [self.tableView reloadData];
    });
}

@end

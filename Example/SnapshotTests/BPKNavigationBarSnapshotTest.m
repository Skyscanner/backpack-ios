//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Backpack/NavigationBar.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

NSString *const CellIdentifier = @"CellId";

@interface BPKNavigationBarSnapshotTest : FBSnapshotTestCase <UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UIViewController *containerVC;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) BPKNavigationBar *navigationBar;
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKNavigationBarSnapshotTest

- (void)setUp {
    [super setUp];
    [self setupView];
    self.recordMode = NO;
}

- (void)setupView {
    self.containerVC = [UIViewController new];
    self.containerVC.view.backgroundColor = UIColor.whiteColor;

    self.navigationBar = [[BPKNavigationBar alloc] initWithFrame:CGRectZero];
    self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerVC.view addSubview:self.navigationBar];
    [self.navigationBar.leadingAnchor constraintEqualToAnchor:self.containerVC.view.leadingAnchor].active = YES;
    [self.navigationBar.trailingAnchor constraintEqualToAnchor:self.containerVC.view.trailingAnchor].active = YES;

    // We set this constraint with a padding to test simulating the safeArea top inset
    [self.navigationBar.topAnchor constraintEqualToAnchor:self.containerVC.view.topAnchor constant:24].active = YES;
    self.navigationBar.title = @"Explore";

    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerVC.view addSubview:self.tableView];

    [self.tableView.leadingAnchor constraintEqualToAnchor:self.containerVC.view.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.containerVC.view.trailingAnchor].active = YES;
    [self.tableView.topAnchor constraintEqualToAnchor:self.navigationBar.bottomAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.containerVC.view.bottomAnchor].active = YES;

    [self.navigationBar setUpForScrollview:self.tableView];
    [self.containerVC.view bringSubviewToFront:self.navigationBar];

    [self.tableView reloadData];
}

#pragma mark - TableView methods
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = @"hello";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 250;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.navigationBar updateWithScrollView:scrollView];
}

#pragma mark - Tests
- (void)testNavBarPosition {
    FBSnapshotVerifyView(self.containerVC.view, nil);
}

- (void)testNavBarCollapsed {
    NSIndexPath *index = [NSIndexPath indexPathForRow:249 inSection:0];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:NO];
    FBSnapshotVerifyView(self.containerVC.view, nil);
}

@end
NS_ASSUME_NONNULL_END

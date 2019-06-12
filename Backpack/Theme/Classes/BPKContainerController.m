/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2019 Skyscanner Ltd
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

#import "BPKContainerController.h"
#import "BPKTheme.h"

#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKContainerController ()
@property(nonatomic, strong) UIViewController *rootViewController;
@property(nonatomic, strong) Class containerClass;
@end

@implementation BPKContainerController

- (instancetype)initWithContainerClass:(Class)containerClass
                    rootViewController:(nonnull UIViewController *)rootViewController {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        _containerIsActive = YES;
        _containerClass = containerClass;
        _container = [containerClass new];
        self.rootViewController = rootViewController;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.container];

    [self addChildViewController:self.rootViewController];
    self.container.frame = [self frameForContainerView];
    self.rootViewController.view.frame = [self frameForRootController];
    [self.container addSubview:self.rootViewController.view];
    [self.rootViewController didMoveToParentViewController:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.container.frame = [self frameForContainerView];
    self.rootViewController.view.frame = [self frameForRootController];
}

- (void)setContainerIsActive:(BOOL)active {
    BPKAssertMainThread();

    if (_containerIsActive != active) {
        // Container was active, is becoming inactive
        if (_containerIsActive && !active) {
            [self.rootViewController.view removeFromSuperview];
            [self.view addSubview:self.rootViewController.view];
            self.container.hidden = YES;
        } else { // Container was inactive, is becoming active
            [self.rootViewController.view removeFromSuperview];
            [self.container addSubview:self.rootViewController.view];
            self.container.hidden = NO;
        }

        _containerIsActive = active;
        [self reloadViews];
        [self.view setNeedsLayout];
    }
}

- (void)setContainerView:(UIView *)container {
    BPKAssertMainThread();

    if (_container != container) {

        [self.rootViewController.view removeFromSuperview];
        [self.container removeFromSuperview];

        [self.view addSubview:container];
        [container addSubview:self.rootViewController.view];

        _container = container;

        [self reloadViews];
        [self.view setNeedsLayout];
    }
}

- (BPKContainerController *)createIdenticalContainerControllerForRootController:(UIViewController *)rootController {
    return [[BPKContainerController alloc] initWithContainerClass:self.containerClass
                                               rootViewController:rootController];
}

#pragma mark - UIViewController methods

- (nullable UIViewController *)childViewControllerForStatusBarStyle {
    return self.rootViewController;
}

- (nullable UIViewController *)childViewControllerForStatusBarHidden {
    return self.rootViewController;
}

#pragma mark - NSObject methods

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSAssert(NO,
             @"Forwarding unrecognized selector, %@, to `rootViewController` in `BPKContainerController`. It is "
             @"not recommended to rely on this behaviour",
             NSStringFromSelector(aSelector));
    return self.rootViewController;
}

#pragma mark - Private

- (CGRect)frameForContainerView {
    if (self.isContainerActive) {
        return self.view.bounds;
    } else {
        return CGRectZero;
    }
}

- (CGRect)frameForRootController {
    if (self.isContainerActive) {
        return self.container.bounds;
    } else {
        return self.view.bounds;
    }
}

- (void)reloadViews {
    UIWindow *window = self.view.window;

    for (UIView *view in window.subviews) {
        [view removeFromSuperview];
        [window addSubview:view];
    }
}

@end
NS_ASSUME_NONNULL_END

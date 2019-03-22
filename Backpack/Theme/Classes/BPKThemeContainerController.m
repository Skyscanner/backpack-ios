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

#import "BPKThemeContainerController.h"
#import <Backpack/Common.h>


@interface BPKThemeContainerController ()
@property(nonatomic, strong) UIViewController *rootViewController;
@end

@implementation BPKThemeContainerController

- (instancetype)initWithThemeContainer:(UIView *)container
                    rootViewController:(nonnull UIViewController *)rootViewController {
    self = [super init];

    if (self) {
        _themeActive = YES;
        _themeContainer = container;
        self.rootViewController = rootViewController;
    }

    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.themeContainer];

    [self addChildViewController:self.rootViewController];
    [self.themeContainer addSubview:self.rootViewController.view];
    [self.rootViewController didMoveToParentViewController:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if (self.isThemeActive) {
        self.themeContainer.frame = self.view.bounds;
        self.rootViewController.view.frame = self.themeContainer.bounds;
    } else {
        self.rootViewController.view.frame = self.view.bounds;
    }
}

- (void)setThemeActive:(BOOL)themeActive {
    BPKAssertMainThread();

    if (_themeActive != themeActive) {
        // Theme was active is becoming inactive
        if (_themeActive && !themeActive) {
            [self.rootViewController.view removeFromSuperview];
            [self.view addSubview:self.rootViewController.view];
            self.themeContainer.hidden = YES;
        } else { // Theme was inactive is becoming active
            [self.rootViewController.view removeFromSuperview];
            [self.themeContainer addSubview:self.rootViewController.view];
            self.themeContainer.hidden = NO;
        }

        _themeActive = themeActive;
        [self reloadViews];
        [self.view setNeedsLayout];
    }
}

- (void)setThemeContainer:(UIView *)themeContainer {
    BPKAssertMainThread();

    if (_themeContainer != themeContainer) {
        [self.rootViewController.view removeFromSuperview];
        [_themeContainer removeFromSuperview];
        _themeContainer = themeContainer;
        [self.view addSubview:_themeContainer];
        [_themeContainer addSubview:self.rootViewController.view];

        [self reloadViews];
        [self.view setNeedsLayout];
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

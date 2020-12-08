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

#import "BPKTheme.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKThemeContainerController ()
@property(nonatomic, strong) UIViewController *rootViewController;
@end

@implementation BPKThemeContainerController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithThemeDefinition:(id<BPKThemeDefinition>)themeDefinition rootViewController:(nonnull UIViewController *)rootViewController {
    self = [super initWithContainerClass:themeDefinition.themeContainerClass rootViewController:rootViewController];

    if (self) {
        _themeDefinition = themeDefinition;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTheme:) name:BPKTheme.didChangeNotification object:nil];
    }

    return self;
}

- (instancetype)createIdenticalContainerControllerForRootController:(UIViewController *)rootController {
    return [[BPKThemeContainerController alloc] initWithThemeDefinition:_themeDefinition rootViewController:rootController];
}

- (void)receiveTheme:(NSNotification *)notification {
    if ([[notification name] isEqualToString:BPKTheme.didChangeNotification]) {
        NSAssert([[notification.object class] conformsToProtocol:@protocol(BPKThemeDefinition)],
                 @"%@ notification should have an object that conforms to %@", BPKTheme.didChangeNotification,
                 NSStringFromProtocol(@protocol(BPKThemeDefinition)));
        if (![[[notification object] class] conformsToProtocol:@protocol(BPKThemeDefinition)]) {
            return;
        }

        id<BPKThemeDefinition> definition = (id<BPKThemeDefinition>)notification.object;
        [self setThemeDefinition:definition];
    }
}

- (void)setThemeDefinition:(id<BPKThemeDefinition>)themeDefinition {
    BPKAssertMainThread();

    if (_themeDefinition != themeDefinition) {
        _themeDefinition = themeDefinition;

        [super setContainerView:[BPKTheme containerFor:_themeDefinition]];
    }
}

@end
NS_ASSUME_NONNULL_END

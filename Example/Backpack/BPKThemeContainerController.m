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
#import "Backpack_Native-Swift.h"
#import <objc/runtime.h>

@interface BPKThemeContainerController ()
@end

@implementation BPKThemeContainerController

static BPKThemeContainerController *themeContainerController;

+ (BPKThemeContainerController *) themeContainerController {
    return themeContainerController;
}

bool additionalSubviewAdded = NO;

- (void) viewDidLoad {
    [super viewDidLoad];

    themeContainerController = self;
}

+(void) swapThemeContainers {
    BPKThemeContainerController *instance = [self themeContainerController];
    [instance swapThemeContainers];
}

- (void) swapThemeContainers {
    NSString *themeName = ThemingHelpers.currentTheme;

    NSArray *subviewsToPreserve = [[self view] subviews];
    if(additionalSubviewAdded){
        subviewsToPreserve = [[subviewsToPreserve objectAtIndex:0] subviews];
    }

    UIView *themedView = nil;
    if ([themeName  isEqual: @"London"]){
        themedView = [[BPKLondonThemeContainer alloc]initWithFrame:self.view.frame];
    } else if ([themeName  isEqual: @"Hong Kong"]) {
        themedView = [[BPKHongKongThemeContainer alloc]initWithFrame:self.view.frame];
    } else if ([themeName  isEqual: @"Doha"]) {
        themedView = [[BPKDohaThemeContainer alloc]initWithFrame:self.view.frame];
    }else{
        themedView = [[UIView alloc]initWithFrame:self.view.frame];
    }

    [[[self view] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self.view addSubview:themedView];
    additionalSubviewAdded = YES;

    for (UIView *sv in subviewsToPreserve){
        [themedView addSubview:sv];
    }
}

@end

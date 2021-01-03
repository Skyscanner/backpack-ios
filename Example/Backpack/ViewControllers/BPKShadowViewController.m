/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKShadowViewController.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Radii.h>
#import <Backpack/Shadow.h>

const static NSInteger LabelTag = 72817;

@interface BPKShadowViewController ()
@property(strong, nonatomic) IBOutletCollection(UIView) NSArray<UIView *> *shadowViews;
- (void)setupViews;
@end

@implementation BPKShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    NSArray *factoryMethods = @[@"shadowSm", @"shadowLg"];

    NSAssert(factoryMethods.count == self.shadowViews.count, @"Expected equal number of shadow views and factoryMethods");

    for (int i = 0; i < factoryMethods.count; i++) {
        UIView *shadowView = self.shadowViews[i];
        BPKLabel *shadowLabel = [shadowView viewWithTag:LabelTag];
        shadowLabel.text = factoryMethods[i];
        shadowLabel.textColor = [BPKColor skyGrayTint01];

        SEL selector = NSSelectorFromString(factoryMethods[i]);
        NSAssert([BPKShadow respondsToSelector:selector], @"Expected BPKShadow to have factory method called %@", factoryMethods[i]);

        BPKShadow *shadow = [BPKShadow performSelector:selector];
        [shadow applyToLayer:shadowView.layer];
        shadowView.layer.cornerRadius = BPKCornerRadiusXs;
    }
}

@end

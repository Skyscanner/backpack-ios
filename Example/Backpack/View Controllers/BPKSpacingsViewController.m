/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKSpacingsViewController.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

@interface BPKSpacingsViewController ()
@property(strong, nonatomic) IBOutletCollection(BPKLabel) NSArray *labels;
@end

@implementation BPKSpacingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setSpacings];
}

#pragma mark - Private

- (void)setSpacings {
    NSArray<NSString *> *spacingKeys =
        @[@"BPKSpacingSm", @"BPKSpacingMd", @"BPKSpacingBase", @"BPKSpacingLg", @"BPKSpacingXl", @"BPKSpacingXxl"];
    NSArray<NSNumber *> *spacingValues = @[
        [NSNumber numberWithFloat:BPKSpacingSm],
        [NSNumber numberWithFloat:BPKSpacingMd],
        [NSNumber numberWithFloat:BPKSpacingBase],
        [NSNumber numberWithFloat:BPKSpacingLg],
        [NSNumber numberWithFloat:BPKSpacingXl],
        [NSNumber numberWithFloat:BPKSpacingXxl],
    ];
    NSAssert(self.labels.count == spacingKeys.count, @"The number of labels must match the number of selectors above");
    for (int i = 0; i < self.labels.count; i++) {
        BPKLabel *label = self.labels[i];
        label.text = [NSString stringWithFormat:@"%@ = %@", spacingKeys[i], spacingValues[i]];
    }
}

@end

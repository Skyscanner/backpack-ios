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

#import "BPKRadiiViewController.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Radii.h>

@interface BPKRadiiViewController ()
@property(strong, nonatomic) IBOutletCollection(BPKLabel) NSArray *labels;
@end

@implementation BPKRadiiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setLabels];
}

#pragma mark - Private

- (void)setLabels {
    NSArray<NSString *> *keys = @[@"BPKCornerRadiusSm", @"BPKCornerRadiusPill"];

    NSArray<NSNumber *> *values =
        @[[NSNumber numberWithFloat:BPKCornerRadiusSm], [NSNumber numberWithFloat:BPKCornerRadiusPill]];

    NSAssert(self.labels.count == keys.count, @"The number of labels must match the number of keys above");
    for (int i = 0; i < self.labels.count; i++) {
        BPKLabel *label = self.labels[i];
        label.text = [NSString stringWithFormat:@"%@ = %@", keys[i], values[i]];
        label.backgroundColor = [BPKColor skyGrayTint01];
        label.textColor = [BPKColor white];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = [values[i] floatValue];
    }
}

@end

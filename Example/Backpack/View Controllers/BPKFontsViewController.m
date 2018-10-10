/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

#import "BPKFontsViewController.h"
#import <Backpack/Label.h>

@interface BPKFontsViewController ()
@property (nonatomic, assign, getter=isEmphasized) BOOL emphasized;
@property (strong, nonatomic) IBOutletCollection(BPKLabel) NSArray *labels;

- (void)setFontsWithEmphasized:(BOOL)isEmphasized;
@end

@implementation BPKFontsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setFontsWithEmphasized:NO];
}

- (IBAction)toggleEmphasized:(id)sender {
    self.emphasized = !self.isEmphasized;
    [self setFontsWithEmphasized:self.isEmphasized];
}

#pragma mark - Private

- (void)setFontsWithEmphasized:(BOOL)isEmphasized {
    BPKFontStyle styles[] = { BPKFontStyleTextXs, BPKFontStyleTextSm, BPKFontStyleTextBase, BPKFontStyleTextLg, BPKFontStyleTextXl };
    BPKFontStyle emphasizedStyles[] = { BPKFontStyleTextXsEmphasized, BPKFontStyleTextSmEmphasized, BPKFontStyleTextBaseEmphasized, BPKFontStyleTextLgEmphasized, BPKFontStyleTextXlEmphasized };

    NSAssert(self.labels.count == sizeof(styles) / sizeof(styles[0]), @"The number of labels must match the number of styles above");
    NSAssert(self.labels.count == sizeof(emphasizedStyles) / sizeof(emphasizedStyles[0]), @"The number of labels must match the number of styles above");

    for (int i = 0; i < self.labels.count; i++) {
        BPKLabel *label = self.labels[i];
        if (isEmphasized) {
            label.fontStyle = emphasizedStyles[i];
        } else {
            label.fontStyle = styles[i];
        }
        label.text = @"Backpack Rocks";
    }
}

@end

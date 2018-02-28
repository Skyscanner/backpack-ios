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
#import <Backpack/Font.h>
#import <Backpack/Color.h>

@interface BPKFontsViewController ()
@property (nonatomic, assign, getter=isEmphasized) BOOL emphasized;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

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
    NSArray<NSString *> *regularSelectors = @[ @"textXs", @"textSm", @"textBase", @"textLg", @"textXl"];
    NSArray<NSString *> *emphasizedSelectors = @[ @"textXsEmphasized", @"textSmEmphasized", @"textBaseEmphasized", @"textLgEmphasized", @"textXlEmphasized"];

    NSArray<NSString *> *selectors = regularSelectors;
    if (isEmphasized) {
        selectors = emphasizedSelectors;
    }

    NSAssert(self.labels.count == selectors.count, @"The number of labels must match the number of selectors above");
    for (int i = 0; i < self.labels.count; i++) {
        SEL selector = NSSelectorFromString(selectors[i]);
        UILabel *label = self.labels[i];

        if ([BPKFont respondsToSelector:selector]) {
            label.font = [BPKFont performSelector:selector];
            label.text = @"Backpack BPKFont";
            label.textColor = [BPKColor gray700];
        } else {
            NSAssert(NO, @"Invalid selector %@", selectors[i]);
        }
    }
}

@end

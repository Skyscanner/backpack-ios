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

@interface BPKFontsViewController ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray<UILabel *> *labels;

@end

@implementation BPKFontsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<NSString *> *selectors = @[ @"textXs", @"textSm", @"textBase", @"textLg", @"textXl", @"textXxl"];

    NSAssert(self.labels.count == selectors.count, @"The number of labels must match the number of selcetors above");
    for (int i = 0; i < self.labels.count; i++) {
        SEL selector = NSSelectorFromString(selectors[i]);

        if ([BPKFont respondsToSelector:selector]) {
            self.labels[i].font = [BPKFont performSelector:selector];
            self.labels[i].text = selectors[i];
        } else {
            NSAssert(NO, @"Invalid selector %@", selectors[i]);
        }
    }
}

@end

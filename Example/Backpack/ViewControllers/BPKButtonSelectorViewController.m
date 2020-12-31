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

#import "BPKButtonSelectorViewController.h"
#import "BPKButtonsViewController.h"

@interface BPKButtonSelectorViewController ()

@end

@implementation BPKButtonSelectorViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    BPKButtonsViewController *target = segue.destinationViewController;

    target.title = cell.textLabel.text;

    if ([segue.identifier isEqualToString:@"primary"]) {
        target.style = BPKButtonStylePrimary;
    } else if ([segue.identifier isEqualToString:@"secondary"]) {
        target.style = BPKButtonStyleSecondary;
    } else if ([segue.identifier isEqualToString:@"destructive"]) {
        target.style = BPKButtonStyleDestructive;
    } else if ([segue.identifier isEqualToString:@"featured"]) {
        target.style = BPKButtonStyleFeatured;
    } else if ([segue.identifier isEqualToString:@"link"]) {
        target.style = BPKButtonStyleLink;
    } else if ([segue.identifier isEqualToString:@"outline"]) {
        target.style = BPKButtonStyleOutline;
    }
}

@end

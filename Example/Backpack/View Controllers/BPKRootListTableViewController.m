/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

#import "BPKRootListTableViewController.h"
#import "Backpack_Native-Swift.h"
#import <Backpack/Color.h>
#import <Backpack/Icon.h>

@interface BPKRootListTableViewController ()
@property(weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@end

@implementation BPKRootListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *largeSettingsIcon = [BPKIcon templateIconNamed:@"settings" size:BPKIconSizeLarge];
    self.settingsButton.image = largeSettingsIcon;

    self.settingsButton.target = self;
    self.settingsButton.action = @selector(didTapSettingsButton);
}

- (void)didTapSettingsButton {
    [ExampleApp showSettingsView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // We cheat and use the same view controller for both fonts and labels
    if ([segue.identifier isEqualToString:@"ShowFontsSegue"]) {
        segue.destinationViewController.title = NSLocalizedString(@"FONTS_CONTROLLER_TTILE", nil);
    } else if ([segue.identifier isEqualToString:@"ShowLabelsSegue"]) {
        segue.destinationViewController.title = NSLocalizedString(@"LABELS_CONTROLLER_TITLE", nil);
    }
}

@end

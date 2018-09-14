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

#import "BPKButtonsViewController.h"

@interface BPKButtonsViewController ()

@property (nonatomic, strong) IBOutletCollection(BPKButton) NSArray<BPKButton *> *defaultButtons;
@property (nonatomic, strong) IBOutletCollection(BPKButton) NSArray<BPKButton *> *largeButtons;
@property (nonatomic, strong) IBOutletCollection(BPKButton) NSArray<BPKButton *> *rightImageButtons;

@end

@implementation BPKButtonsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupButtons];
}

- (void)setupButtons {
    for (BPKButton *button in self.defaultButtons) {
        [button setImagePosition:BPKButtonImagePositionLeft];
        [button setSize:BPKButtonSizeDefault];
        [button setStlye:self.style];
    }
    
    for (BPKButton *button in self.largeButtons) {
        [button setImagePosition:BPKButtonImagePositionLeft];
        [button setSize:BPKButtonSizeLarge];
        [button setStlye:self.style];
    }
    
    for (BPKButton *button in self.rightImageButtons) {
        [button setImagePosition:BPKButtonImagePositionRight];
    }
}

@end

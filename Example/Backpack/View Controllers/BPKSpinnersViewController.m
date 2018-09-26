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

#import "BPKSpinnersViewController.h"
#import <Backpack/Spinner.h>

@interface BPKSpinnersViewController ()

@property (weak, nonatomic) IBOutlet BPKSpinner *defaultPrimarySpinner;
@property (weak, nonatomic) IBOutlet BPKSpinner *defaultDarkSpinner;
@property (weak, nonatomic) IBOutlet BPKSpinner *defaultLightSpinner;
@property (weak, nonatomic) IBOutlet BPKSpinner *smallPrimarySpinner;
@property (weak, nonatomic) IBOutlet BPKSpinner *smallDarkSpinner;
@property (weak, nonatomic) IBOutlet BPKSpinner *smallLightSpinner;

@end

@implementation BPKSpinnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.defaultPrimarySpinner.size = BPKSpinnerSizeDefault;
    self.defaultPrimarySpinner.style = BPKSpinnerStylePrimary;
    
    self.defaultDarkSpinner.size = BPKSpinnerSizeDefault;
    self.defaultDarkSpinner.style = BPKSpinnerStyleDark;
    
    self.defaultLightSpinner.size = BPKSpinnerSizeDefault;
    self.defaultLightSpinner.style = BPKSpinnerStyleLight;
    
    self.smallPrimarySpinner.size = BPKSpinnerSizeSmall;
    self.smallPrimarySpinner.style = BPKSpinnerStylePrimary;
    
    self.smallDarkSpinner.size = BPKSpinnerSizeSmall;
    self.smallDarkSpinner.style = BPKSpinnerStyleDark;
    
    self.smallLightSpinner.size = BPKSpinnerSizeSmall;
    self.smallLightSpinner.style = BPKSpinnerStyleLight;
}

@end

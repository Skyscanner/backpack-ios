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

#import "BPKExampleApp.h"
#import <Backpack/Color.h>

@implementation BPKExampleApp

- (void)sendEvent:(UIEvent *)event
{
    if ( event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake ) {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        UIViewController *rvc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [rvc presentViewController:vc animated:YES completion:nil];
    }
    
    [super sendEvent:event];
}

@end

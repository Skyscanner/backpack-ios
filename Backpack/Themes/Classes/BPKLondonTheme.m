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

#import "BPKLondonTheme.h"
#import "BPKLondonThemeContainer.h"
#import <Backpack/Switch.h>
#import <Backpack/Button.h>
#import <Backpack/Chip.h>
#import <Backpack/Spinner.h>

/*
 const londonTheme = {
 primaryColor300: '#F28494',
 primaryColor500: '#ED1B28',
 primaryColor600: '#D11622',
 primaryColor700: '#B1121C',
 secondaryColor300: '#6889AB',
 secondaryColor500: '#013A76',
 secondaryColor600: '#002F61',
 secondaryColor700: '#00254B',
 docsSidebarBackground: '#013A76',
 docsSidebarLink: '#6889AB',
 docsSidebarLinkBorder: '#6889AB',
 docsSidebarSelectedArrowColor: '#ED1B28',
 };
*/



@implementation BPKLondonTheme


+ (void)apply
{
    UIColor *primaryColor500 = [UIColor  colorWithRed:237.0f/255.0f green:27.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    UIColor *primaryColor600 = [UIColor  colorWithRed:209.0f/255.0f green:22.0f/255.0f blue:34.0f/255.0f alpha:1.0f];
    UIColor *darkColor700 = [UIColor  colorWithRed:0.0f/255.0f green:37.0f/255.0f blue:75.0f/255.0f alpha:1.0f];

    [[BPKSwitch appearanceWhenContainedInInstancesOfClasses:@[[BPKLondonThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKButton appearanceWhenContainedInInstancesOfClasses:@[[BPKLondonThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKButton appearanceWhenContainedInInstancesOfClasses:@[[BPKLondonThemeContainer class]]]setPrimaryColor600:primaryColor600];
    [[BPKChip appearanceWhenContainedInInstancesOfClasses:@[[BPKLondonThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKSpinner appearanceWhenContainedInInstancesOfClasses:@[[BPKLondonThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKSpinner appearanceWhenContainedInInstancesOfClasses:@[[BPKLondonThemeContainer class]]]setDarkColor700:darkColor700];
}

@end

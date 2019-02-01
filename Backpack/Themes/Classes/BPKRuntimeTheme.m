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

#import "BPKRuntimeTheme.h"
#import "BPKLondonThemeContainer.h"
#import <objc/runtime.h>
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



@implementation BPKRuntimeTheme

static NSMutableArray<NSString *> *registeredSubclasses;


+ (UIView*)applyTheme:(NSDictionary*)themeSpecification
{
    if (registeredSubclasses == nil) {
        registeredSubclasses = [[NSMutableArray alloc] init];
    }

    NSString *className = [NSString stringWithFormat: @"CustomThemeContainer%lu", (unsigned long)[[themeSpecification description] hash]] ;

    Class CustomThemeContainer = objc_allocateClassPair([UIView class], [className UTF8String], 0);

    if([registeredSubclasses containsObject:className]){
        UIView *classInstance = [[NSClassFromString(className) alloc] init];
        return classInstance;
    }

    [registeredSubclasses addObject:className];

    objc_registerClassPair(CustomThemeContainer);

    UIColor *primaryColor500 = themeSpecification[@"primaryColor500"];
    UIColor *primaryColor600 = themeSpecification[@"primaryColor600"];
    UIColor *darkColor700 = themeSpecification[@"darkColor700"];

    [[BPKSwitch appearanceWhenContainedInInstancesOfClasses:@[[CustomThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKButton appearanceWhenContainedInInstancesOfClasses:@[[CustomThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKButton appearanceWhenContainedInInstancesOfClasses:@[[CustomThemeContainer class]]]setPrimaryColor600:primaryColor600];
    [[BPKChip appearanceWhenContainedInInstancesOfClasses:@[[CustomThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKSpinner appearanceWhenContainedInInstancesOfClasses:@[[CustomThemeContainer class]]]setPrimaryColor500:primaryColor500];
    [[BPKSpinner appearanceWhenContainedInInstancesOfClasses:@[[CustomThemeContainer class]]]setDarkColor700:darkColor700];

    UIView *classInstance = [[CustomThemeContainer alloc] init];
    return classInstance;
}

@end

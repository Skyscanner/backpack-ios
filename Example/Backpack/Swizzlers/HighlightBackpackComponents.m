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

#import "HighlightBackpackComponents.h"
#import <objc/runtime.h>

@implementation UIView (HighlightBackpackComponents)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Class class = [self class];

        printf("DOING THE SWIZZLING NOW\nHighlightBackpackComponents load\n\n");

        SEL defaultSelector = @selector(setNeedsDisplay);
        SEL swizzledSelector = @selector(swizzled_setNeedsDisplay);

        Method defaultMethod = class_getInstanceMethod(class, defaultSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL isMethodExists = !class_addMethod(class, defaultSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

        if (isMethodExists) {
            method_exchangeImplementations(defaultMethod, swizzledMethod);
        }
        else {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
        }
    });
}

#pragma mark - Method Swizzling
-(void)swizzled_setNeedsDisplay {
    [self swizzled_setNeedsDisplay];

    // TODO Store the view in the instance so that we don't keep recreating it

    // TODO In apps codebase, simply add condition on debug switch being set
    NSString *componentName = NSStringFromClass([self class]);
    if([componentName hasPrefix:@"BPK"]) {
        UIView *myBox  = [[UIView alloc] initWithFrame:self.bounds];
        myBox.backgroundColor =  [UIColor purpleColor];
        [myBox setAlpha:0.2];
        [myBox setUserInteractionEnabled:NO];
        [self addSubview:myBox];
        printf("%s swizzled\n\n", [componentName UTF8String]);
    }
}

@end

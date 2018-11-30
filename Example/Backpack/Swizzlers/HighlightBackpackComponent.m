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

#import "HighlightBackpackComponent.h"
#import <objc/runtime.h>

@implementation CALayer (HighlightBackpackComponent)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Class class = [self class];

        printf("DOING THE SWIZZLING NOW\nHighlightBackpackComponent load\n\n");

        SEL defaultSelector = @selector(display);
        SEL swizzledSelector = @selector(swizzled_display);

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
-(void)swizzled_display {
    [self swizzled_display];

    // TODO Store the view in the instance so that we don't keep recreating it

    // TODO In apps codebase, simply add condition on debug switch being set
    NSString *componentName = NSStringFromClass([self.delegate class]);
    printf("Component: %s\n\n", [componentName UTF8String]);
    if([componentName hasPrefix:@"BPK"]) {

        CALayer *tintLayer = [CALayer layer];
        [tintLayer setFrame:self.frame];
        printf("bounds: %s\n", [NSStringFromCGSize(self.bounds.size) UTF8String]);
        tintLayer.backgroundColor = [UIColor greenColor].CGColor;
        tintLayer.opacity = 0.2;
        [self addSublayer:tintLayer];

        printf("%s swizzled\n\n", [componentName UTF8String]);
    }
}

//-(UIView*)getParentView:(CALayer*)layer {
//    if([layer.delegate class] == [UIView class]){
//        return layer.delegate;
//    }else {
////        return getParentView:layer.delegate;
//    }
//}

@end

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

        SEL defaultSelector = @selector(initWithFrame:);
        SEL swizzledSelector = @selector(swizzled_initWithFrame:);

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
-(id)swizzled_initWithFrame:(CGRect)frame {
    // This looks like a mistake - the method is calling itself. However this is correct
    // practise for swizzling. So just trust me, yeah?
    id result = [self swizzled_initWithFrame:frame];

    // TODO In apps codebase, simply add condition on debug switch being set

    // TODO what if the setup actually causes the layer properties we set to be overridden?
    // Do we need to handle such events and swallow them? - maybe swizzle `setBorderColor` too?

    //    // Safe guard: do we have an UIView (or something that has a layer)?
    if ([result respondsToSelector:@selector(layer)]) {
        NSString *componentName = NSStringFromClass([self class]);
        if([componentName hasPrefix:@"BPK"]) {
            // Get layer for this view.
            CALayer *layer = [result layer];
            // Set border on layer.
            layer.borderWidth = 2;
            layer.borderColor = [[UIColor redColor] CGColor];
            printf("%s swizzled\n\n", [componentName UTF8String]);

            //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
            //        tap.delegate = self;
            //        tap.numberOfTapsRequired = 3;
            //        tap.numberOfTouchesRequired = 1;
            //        [self addGestureRecognizer:tap];
        }
    }

    return result;

    // This is how I was originally trying to highlight BPK components:
    //    NSString *componentName = NSStringFromClass([self class]);
    //    if([componentName hasPrefix:@"BPK"]) {
    //        UIView *myBox  = [[UIView alloc] initWithFrame:self.bounds];
    //        myBox.backgroundColor =  [UIColor purpleColor];
    //        [myBox setAlpha:0.2];
    //        [myBox setUserInteractionEnabled:NO];
    //        [self addSubview:myBox];
    //        printf("%s swizzled\n\n", [componentName UTF8String]);
    //    }
}

@end

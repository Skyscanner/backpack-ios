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
// #import <SKYConfig/SKYConfigRepository.h>
// #import <SKYSharedLogic/ConfigurationConstants.h>

@implementation UIView (HighlightBackpackComponents)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        if ([[SKYConfigRepository shared] isOn:kC_BackpackCoverageIndicators])
//        {
            Class class = [UIView class];

            [self swizzleClass:class defaultSelector:@selector(initWithFrame:) swizzledSelector:@selector(swizzled_initWithFrame:)];
            [self swizzleClass:class defaultSelector:@selector(initWithCoder:) swizzledSelector:@selector(swizzled_initWithCoder:)];
            [self swizzleClass:class defaultSelector:@selector(didAddSubview:) swizzledSelector:@selector(swizzled_didAddSubview:)];
//        }
    });
}

+ (void) swizzleClass:(Class)class defaultSelector:(SEL)defaultSelector swizzledSelector:(SEL)swizzledSelector {
    Method defaultMethod = class_getInstanceMethod(class, defaultSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL isMethodExists = !class_addMethod(class, defaultSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (isMethodExists) {
        method_exchangeImplementations(defaultMethod, swizzledMethod);
    }
    else {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
    }
}

#pragma mark - Method Swizzling

-(id)swizzled_initWithFrame:(CGRect)frame {
    // This looks like a mistake - the method is calling itself. However this is correct
    // practise for swizzling. So just trust me, yeah?
    id result = [self swizzled_initWithFrame:frame];

    [self addBackpackIdentifierView];

    return result;
}

-(id)swizzled_initWithCoder:(NSCoder *)aDecoder {
    // This looks like a mistake - the method is calling itself. However this is correct
    // practise for swizzling. So just trust me, yeah?
    id result = [self swizzled_initWithCoder:aDecoder];

    [self addBackpackIdentifierView];

    return result;
}

-(void)addBackpackIdentifierView {
    if([self shouldAddIndicatorView]) {
        UIView *myBox  = [[UIView alloc] initWithFrame:CGRectZero];
        myBox.backgroundColor =  [UIColor purpleColor];
        myBox.userInteractionEnabled = NO;
        myBox.exclusiveTouch = NO;
        myBox.exclusiveTouch = NO;
        myBox.alpha = 0.4;
        myBox.translatesAutoresizingMaskIntoConstraints = NO;

        [self didAddSubview:myBox];

        [NSLayoutConstraint activateConstraints:@[
                                                  [myBox.widthAnchor constraintGreaterThanOrEqualToConstant:30],
                                                  [myBox.heightAnchor constraintGreaterThanOrEqualToConstant:10],
                                                  [myBox.widthAnchor constraintEqualToAnchor:self.widthAnchor],
                                                  [myBox.heightAnchor constraintEqualToAnchor:self.heightAnchor],
                                                  [myBox.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                                                  [myBox.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                                  ]];

        objc_setAssociatedObject(self, "myBox", myBox, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (void)swizzled_didAddSubview:(UIView *)subview {
    // This looks like a mistake - the method is calling itself. However this is correct
    // practise for swizzling. So just trust me, yeah?
    [self swizzled_didAddSubview:subview];

    if([self shouldAddIndicatorView]) {
        if (subview.superview == nil) {
            [self addSubview:subview];
        }
    }
}

- (BOOL)shouldAddIndicatorView {
    NSString *componentName = NSStringFromClass([self class]);
    return [componentName hasPrefix:@"BPK"];
}

@end


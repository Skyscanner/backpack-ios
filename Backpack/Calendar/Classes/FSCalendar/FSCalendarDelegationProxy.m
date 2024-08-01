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

/*
 * Copyright (c) 2013-2016 FSCalendar (https://github.com/WenchaoD/FSCalendar)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "FSCalendarDelegationProxy.h"
#import <objc/runtime.h>

@implementation FSCalendarDelegationProxy

- (instancetype)init {
    return self;
}

- (BOOL)respondsToSelector:(SEL)selector {
    BOOL responds = [self.delegation respondsToSelector:selector];
    if (!responds)
        responds = [self.delegation respondsToSelector:[self deprecatedSelectorOfSelector:selector]];
    if (!responds)
        responds = [super respondsToSelector:selector];
    return responds;
}

- (BOOL)conformsToProtocol:(Protocol *)protocol {
    return [self.delegation conformsToProtocol:protocol];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = invocation.selector;
    if (![self.delegation respondsToSelector:selector]) {
        selector = [self deprecatedSelectorOfSelector:selector];
        invocation.selector = selector;
    }
    if ([self.delegation respondsToSelector:selector]) {
        [invocation invokeWithTarget:self.delegation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if ([self.delegation respondsToSelector:sel]) {
        return [(NSObject *)self.delegation methodSignatureForSelector:sel];
    }
    SEL selector = [self deprecatedSelectorOfSelector:sel];
    if ([self.delegation respondsToSelector:selector]) {
        return [(NSObject *)self.delegation methodSignatureForSelector:selector];
    }
#if TARGET_INTERFACE_BUILDER
    return [NSObject methodSignatureForSelector:@selector(init)];
#else
    struct objc_method_description desc = protocol_getMethodDescription(self.protocol, sel, NO, YES);
    const char *types = desc.types;
    return types ? [NSMethodSignature signatureWithObjCTypes:types] : [NSObject methodSignatureForSelector:@selector(init)];
#endif
}

- (SEL)deprecatedSelectorOfSelector:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    selectorString = self.deprecations[selectorString];
    return NSSelectorFromString(selectorString);
}

@end

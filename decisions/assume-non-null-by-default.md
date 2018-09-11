# Assume non-null by default in Objective-C

## TL;DR

Swift uses a default model where nullability has to be explicitly expressed. In Objective-C the default is the opposite. To avoid confusion and help us ensure null-safety we invert the behaviour in Objective-C to assume all pointers are non-null unless otherwise specified.

## Decision

All Objective-C .h/.m files should be wrapped in the `NS_ASSUME_NONNULL_BEGIN` and `NS_ASSUME_NONNULL_END` markers respectively.

**Example:**

```objective-c
// MyClass.h
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface MyClass
@property(nonatomic, copy) NSString *a;
@property(nullable, nonatomic, copy) NSString *b;
@end
NS_ASSSUME_NONNULL_END
```

```objective-c
// MyClass.m
#import "MyClass.h"

NS_ASSUME_NONNULL_BEGIN
@interface MyClass()
@end

@implementation
@end
NS_ASSSUME_NONNULL_END
```

## Thinking

Aligning with the Swift default will make our code nicer to use from Swift and reduce typing as most pointers are `nonnull` rather than `nullable`. Furthermore the compiler will help us more by preventing us from breaking this contract than if pointers were `nullable` by default.


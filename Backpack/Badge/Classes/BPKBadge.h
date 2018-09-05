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
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * These constants represent the type of badge.
 */
typedef NS_ENUM(NSUInteger, BPKBadgeType) {

    /**
     * Success badge type.
     */
    BPKBadgeTypeSuccess = 0,

    /**
     * Warning badge type.
     */
    BPKBadgeTypeWarning,

    /**
     * Destructive badge type.
     */
    BPKBadgeTypeDestructive,

    /**
     * Light badge type.
     */
    BPKBadgeTypeLight,

    /**
     * Inverse badge type.
     */
    BPKBadgeTypeInverse,

    /**
     * Outline badge type.
     */
    BPKBadgeTypeOutline,
    
    /**
     * Gray badge type.
     */
    BPKBadgeTypeGray
};

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE @interface BPKBadge: UIView
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * The type of the badge.
 */
@property(nonatomic, assign) BPKBadgeType type;

/**
 * The message to show inside the badge.
 */
@property(nonatomic, copy) IBInspectable NSString *message;

/**
 * Create a `BPKBadge` with the given message.
 * 
 * @param message The message to show in the badge.
 */
- (instancetype)initWithMessage:(NSString *)message;

/**
 * Create a `BPKBadge` with the given message and type.
 * 
 * @param type The type of badge to create.
 * @param message The message to show in the badge.
 */
- (instancetype)initWithType:(BPKBadgeType)type message:(NSString *)message NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end
NS_ASSUME_NONNULL_END

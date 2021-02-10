/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKMapAnnotation` is a subclass of `MKPointAnnotation` which which can be used to represent a `BPKMapAnnotationView`.
 */
@interface BPKMapAnnotation : MKPointAnnotation

/**
 * Whether to always show the callout. If false, the callout will only be shown when the annotation is selected.
 */
@property(nonatomic, assign) BOOL alwaysShowCallout;

/**
 * Whether the annotation is enabled. If false, a user cannot interact with the annotation.
 */
@property(nonatomic, assign) BOOL enabled;

@end
NS_ASSUME_NONNULL_END

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

#import <Backpack/FlareView.h>

NS_ASSUME_NONNULL_BEGIN

@class BPKMapAnnotationView;

/**
 * `BPKMapAnnotationViewCalloutView` is a subclass of `BPKFlareView` which contains the Skyscanner map callout style.
 */
IB_DESIGNABLE @interface BPKMapAnnotationViewCalloutView : BPKFlareView

/**
 * The `BPKMapAnnotationView` that created the callout.
 */
@property(nonatomic, weak, nullable) BPKMapAnnotationView *annotationView;

/// :nodoc:
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/// :nodoc:
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Create a `BPKMapAnnotationViewCalloutView` with the given text.
 *
 * @param annotationView The annotation view of the callout.
 */
- (instancetype)initWithAnnotationView:(BPKMapAnnotationView *)annotationView NS_DESIGNATED_INITIALIZER;

-(void)update;

@end
NS_ASSUME_NONNULL_END

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

#import "BPKMapAnnotationView.h"

#import <Backpack/Color.h>
#import <Backpack/Spacing.h>

#import "BPKMapAnnotationViewCalloutView.h"
#import "BPKMapAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKMapAnnotationView()
@property(nonatomic, nullable, readonly) BPKMapAnnotation *bpk_annotation;
@property(nonatomic, nullable, strong) UIView *dotView;
@property(nonatomic, nullable, strong) BPKMapAnnotationViewCalloutView *calloutView;
@end

@implementation BPKMapAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation> _Nullable)annotation reuseIdentifier:(NSString * _Nullable)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];

    if (self) {
        [self setupAppearance];
    }

    return self;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setupAppearance];
    }

    return self;
}

-(BPKMapAnnotation *_Nullable)bpk_annotation {
    if(self.annotation == nil) {
        return nil;
    }

    if(![self.annotation isKindOfClass:BPKMapAnnotation.class]) {
        return nil;
    }

    return (BPKMapAnnotation *)self.annotation;
}

-(void)setupAppearance {
    [self updateImage];

    self.dotView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.dotView];
    self.dotView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        // These constraints use magic numbers to ensure that the dot appears in the correct position on the map.
        // The UIKit PinAnnotationView isn't centered by default.
        [self.dotView.centerXAnchor constraintEqualToAnchor:self.leadingAnchor constant:8],
        [self.dotView.centerYAnchor constraintEqualToAnchor:self.bottomAnchor constant:-2],
        [self.dotView.widthAnchor constraintEqualToConstant:BPKSpacingLg],
        [self.dotView.heightAnchor constraintEqualToConstant:BPKSpacingLg]
    ]];
    self.dotView.backgroundColor = BPKColor.skyBlue;
    self.dotView.layer.borderColor = BPKColor.white.CGColor;
    self.dotView.layer.borderWidth = BPKSpacingSm;
    self.dotView.layer.cornerRadius = BPKSpacingLg/2;
    [self updateCallout];
}

-(void)createCallout {
    if (self.dotView == nil) {
        return;
    }

    self.calloutView = [[BPKMapAnnotationViewCalloutView alloc] initWithAnnotationView:self];
    [self addSubview:self.calloutView];
    self.calloutView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.calloutView.centerXAnchor constraintEqualToAnchor:self.dotView.centerXAnchor],
        [self.calloutView.bottomAnchor constraintEqualToAnchor:self.dotView.topAnchor constant:BPKSpacingSm / 2]
    ]];
}

-(void)destroyCallout {
    [self.calloutView removeFromSuperview];
    self.calloutView = nil;
}

-(void)updateImage {
    self.image = nil;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    self.hasBeenSelected = self.hasBeenSelected || selected;
    [self updateCallout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.hasBeenSelected = self.hasBeenSelected || selected;
    [self updateCallout];
}

- (void)setAnnotation:(id<MKAnnotation> _Nullable)annotation {
    [super setAnnotation:annotation];

    [self updateCallout];
}

-(void)updateCallout {
    self.enabled = self.bpk_annotation.enabled;

    BOOL shouldShowCallout = self.selected || self.bpk_annotation.alwaysShowCallout;
    if(shouldShowCallout && self.calloutView == nil) {
        [self createCallout];
    }
    if(!shouldShowCallout && self.calloutView != nil) {
        [self destroyCallout];
    }

    [self.calloutView update];
}

- (void)traitCollectionDidChange:(UITraitCollection * _Nullable)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];

    if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
        [self updateImage];
    }
}

@end
NS_ASSUME_NONNULL_END

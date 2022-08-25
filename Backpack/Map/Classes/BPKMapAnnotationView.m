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

#import "BPKMapAnnotationView.h"

#import <Backpack/Color.h>
#import <Backpack/Spacing.h>

#import "BPKMapAnnotation.h"
#import "BPKMapAnnotationViewCalloutView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKMapAnnotationView ()
@property(nonatomic, nullable, readonly) BPKMapAnnotation *bpk_annotation;
@property(nonatomic, nullable, strong) UIView *dotView;
@property(nonatomic, strong) BPKMapAnnotationViewCalloutView *calloutView;
@property(nonatomic, readonly) CGFloat annotationDotHeight;
@property(nonatomic, readonly) CGFloat calloutViewOverlap;

@end

@implementation BPKMapAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation> _Nullable)annotation reuseIdentifier:(NSString *_Nullable)reuseIdentifier {
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

- (BPKMapAnnotation *_Nullable)bpk_annotation {
    if (self.annotation == nil) {
        return nil;
    }

    if (![self.annotation isKindOfClass:BPKMapAnnotation.class]) {
        NSAssert(false, @"BPKMapAnnotationView should be initialised with an instance of BPKMapAnnotation. Instead annotation class is %@",
                 self.annotation.class);
        return nil;
    }

    return (BPKMapAnnotation *)self.annotation;
}

- (void)setupAppearance {
    self.hasBeenSelected = false;
    [self updateImage];

    self.dotView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.dotView];

    self.dotView.backgroundColor = BPKColor.coreAccentColor;
    self.dotView.layer.borderWidth = BPKSpacingSm / 2;
    self.dotView.layer.cornerRadius = self.annotationDotHeight / 2;
    [self updateAppearance];
}

- (BPKMapAnnotationViewCalloutView *)calloutView {
    if (_calloutView == nil && self.dotView != nil) {
        BPKMapAnnotationViewCalloutView *calloutView = [[BPKMapAnnotationViewCalloutView alloc] initWithAnnotationView:self];
        [self addSubview:calloutView];
        calloutView.translatesAutoresizingMaskIntoConstraints = NO;
        _calloutView = calloutView;
    }

    return _calloutView;
}

- (void)updateImage {
    self.image = nil;
}

- (void)setSelected:(BOOL)selected {
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.hasBeenSelected = self.hasBeenSelected || selected;
    [self updateAppearance];
}

- (void)setAnnotation:(id<MKAnnotation> _Nullable)annotation {
    [super setAnnotation:annotation];

    [self updateAppearance];
}

- (void)updateAccessibilityProperties {
    self.accessibilityLabel = self.bpk_annotation.accessibilityLabel;
    self.accessibilityValue = self.bpk_annotation.accessibilityValue;
    self.accessibilityHint = self.bpk_annotation.accessibilityHint;
}

- (void)updateAppearance {
    [self updateAccessibilityProperties];
    self.enabled = self.bpk_annotation.enabled;
    self.dotView.layer.borderColor = BPKColor.surfaceDefaultColor.CGColor;

    BOOL shouldShowCallout = self.selected || self.bpk_annotation.alwaysShowCallout;
    if (shouldShowCallout) {
        self.calloutView.hidden = false;
    }

    // Using `_calloutView` so that if it is not already created we don't access the lazy property
    if (!shouldShowCallout && _calloutView != nil) {
        self.calloutView.hidden = true;
    }

    // Using `_calloutView` so that if it is not already created we don't access the lazy property
    if (_calloutView != nil) {
        [self.calloutView update];
    }

    [self updateBounds];
}

- (void)updateBounds {
    // Using `_calloutView` so that if it is not already created we don't access the lazy property
    if (_calloutView == nil || self.calloutView.hidden) {
        self.bounds = CGRectMake(0, 0, self.annotationDotHeight, self.annotationDotHeight);
    } else {
        CGSize calloutViewSize = [self.calloutView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        self.bounds = CGRectMake(0, 0, calloutViewSize.width, calloutViewSize.height + self.annotationDotHeight - self.calloutViewOverlap);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // Using `_calloutView` so that if it is not already created we don't access the lazy property
    if (_calloutView == nil || self.calloutView.hidden) {
        self.dotView.frame = CGRectMake(0, 0, self.annotationDotHeight, self.annotationDotHeight);
        self.centerOffset = CGPointMake(0, 0);
    } else {
        CGSize calloutViewSize = [self.calloutView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        self.calloutView.frame = CGRectMake(0, 0, calloutViewSize.width, calloutViewSize.height);

        CGFloat dotLeft = (calloutViewSize.width - self.annotationDotHeight) / 2;
        CGFloat dotTop = calloutViewSize.height - self.calloutViewOverlap;
        self.dotView.frame = CGRectMake(dotLeft, dotTop, self.annotationDotHeight, self.annotationDotHeight);

        CGFloat offset = -(self.bounds.size.height / 2) + (self.annotationDotHeight / 2);
        self.centerOffset = CGPointMake(0, offset);
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *_Nullable)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];

    if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
        [self updateAppearance];
        [self updateImage];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.hasBeenSelected = false;
}

#pragma mark - constants

/*
 * The height of the annotation dot.
 * It does not matter that this is too small a hit target, as the MKAnnotationContainerView handles hit-test logic.
 */
- (CGFloat)annotationDotHeight {
    return BPKSpacingBase;
}

- (CGFloat)calloutViewOverlap {
    return BPKSpacingSm / 2;
}

@end
NS_ASSUME_NONNULL_END

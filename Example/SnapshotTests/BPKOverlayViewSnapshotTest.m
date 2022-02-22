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

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/OverlayView.h>
#import <Backpack/Spacing.h>

#import "BPKSnapshotTest.h"

@interface BPKOverlayViewSnapshotTest : FBSnapshotTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKOverlayViewSnapshotTest

+ (CGRect)deviceFrame {
    // 375x812 = iPhone X dimensions.
    return CGRectMake(0, 0, 375, 812);
}

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (UIView *)buildParentView {
    UIView *parentView = [[UIView alloc] initWithFrame:[self class].deviceFrame];
    parentView.backgroundColor = [BPKColor skyGrayTint06];
    return parentView;
}

- (UIStackView *)buildStackView {
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:[self class].deviceFrame];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualCentering;
    return stackView;
}

- (UIView *)createStackWithBackground:(BOOL)background foreground:(BOOL)foreground {
    UIStackView *stackView = [self buildStackView];

    NSArray<BPKOverlayView *> *overlayViews = @[
        [[BPKOverlayView alloc] initWithOverlayType:BPKOverlayViewOverlayTypeNone cornerStyle:BPKOverlayViewCornerStyleNone],
        [[BPKOverlayView alloc] initWithOverlayType:BPKOverlayViewOverlayTypeTint cornerStyle:BPKOverlayViewCornerStyleNone],
        [[BPKOverlayView alloc] initWithOverlayType:BPKOverlayViewOverlayTypeTint cornerStyle:BPKOverlayViewCornerStyleSmall],
        [[BPKOverlayView alloc] initWithOverlayType:BPKOverlayViewOverlayTypeTint cornerStyle:BPKOverlayViewCornerStyleLarge]
    ];

    for (BPKOverlayView *overlayView in overlayViews) {
        if (background) {
            UIView *backgroundContent = [self createBackgroundView];
            [overlayView.backgroundView addSubview:backgroundContent];
            [NSLayoutConstraint activateConstraints:@[
                [backgroundContent.topAnchor constraintEqualToAnchor:overlayView.backgroundView.topAnchor],
                [backgroundContent.leadingAnchor constraintEqualToAnchor:overlayView.backgroundView.leadingAnchor],
                [backgroundContent.trailingAnchor constraintEqualToAnchor:overlayView.backgroundView.trailingAnchor],
                [backgroundContent.bottomAnchor constraintEqualToAnchor:overlayView.backgroundView.bottomAnchor]
            ]];

            // This is a hack used to reorder the layers before they are captured by the snapshot library.
            // This is necessary due to an issue with how UIGraphicsImageRenderer orders layers.
            // See
            // https://stackoverflow.com/questions/62172205/saving-a-uiview-as-an-image-causes-zpositioning-of-its-subviews-to-fail
            CALayer *tintLayer = overlayView.backgroundView.layer.sublayers[0];
            [overlayView.backgroundView.layer.sublayers[0] removeFromSuperlayer];
            [overlayView.backgroundView.layer insertSublayer:tintLayer atIndex:1];
        }
        if (foreground) {
            UIView *foregroundContent = [self createForegroundView];
            [overlayView.foregroundView addSubview:foregroundContent];
            [NSLayoutConstraint activateConstraints:@[
                [foregroundContent.widthAnchor constraintEqualToAnchor:overlayView.foregroundView.widthAnchor constant:-BPKSpacingLg],
                [foregroundContent.centerXAnchor constraintEqualToAnchor:overlayView.foregroundView.centerXAnchor],
                [foregroundContent.centerYAnchor constraintEqualToAnchor:overlayView.foregroundView.centerYAnchor],
                [overlayView.foregroundView.heightAnchor constraintGreaterThanOrEqualToConstant:100],
                [overlayView.foregroundView.widthAnchor constraintGreaterThanOrEqualToConstant:100]
            ]];
        }

        [stackView addArrangedSubview:overlayView];
        [overlayView sizeToFit];
    }

    UIView *parentView = [self buildParentView];
    [parentView addSubview:stackView];

    return parentView;
}

- (UIView *)createBackgroundView {
    UIImage *image = [UIImage imageNamed:@"pilanesburg-south-africa"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint
        activateConstraints:@[[imageView.widthAnchor constraintEqualToConstant:200], [imageView.heightAnchor constraintEqualToConstant:150]]];
    return imageView;
}

- (UIView *)createForegroundView {
    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBodyDefault];
    label.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit.";
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.textColor = BPKColor.white;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    return label;
}

- (UIView *)createOverlayViewsWithBackground {
    return [self createStackWithBackground:YES foreground:NO];
}

- (UIView *)createOverlayViewsWithForeground {
    return [self createStackWithBackground:NO foreground:YES];
}

- (UIView *)createOverlayViewsWithBackgroundAndForeground {
    return [self createStackWithBackground:YES foreground:YES];
}

- (void)testOverlayViewsWithBackground {
    UIView *lightView = [self createOverlayViewsWithBackground];
    UIView *darkView = [self createOverlayViewsWithBackground];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (void)testOverlayViewsWithForeground {
    UIView *lightView = [self createOverlayViewsWithForeground];
    UIView *darkView = [self createOverlayViewsWithForeground];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (void)testOverlayViewsWithBackgroundAndForeground {
    UIView *lightView = [self createOverlayViewsWithBackgroundAndForeground];
    UIView *darkView = [self createOverlayViewsWithBackgroundAndForeground];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end

NS_ASSUME_NONNULL_END

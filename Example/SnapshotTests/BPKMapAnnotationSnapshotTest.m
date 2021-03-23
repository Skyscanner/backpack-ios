//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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

#import <Backpack/Spacing.h>
#import <Backpack/Map.h>

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import "BPKSnapshotTest.h"

NSString *const ReuseIdentifier = @"Annotation";
CGFloat const annotationHeight = 65;
CGFloat const annotationWidth = 120;

@interface BPKMapAnnotationSnapshotTest : FBSnapshotTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKMapAnnotationSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

-(UIView *)createMapAnnotationWithLabel:(NSString *)label alwaysShowCallout:(BOOL)alwaysShowCallout previouslySelected:(BOOL)previouslySelected selected:(BOOL)selected enabled:(BOOL)enabled icon:(BOOL)icon {
    BPKMapAnnotation *annotation =  [[BPKMapAnnotation alloc] init];
    annotation.title = label;
    annotation.alwaysShowCallout = alwaysShowCallout;
    annotation.enabled = enabled;
    if (icon) {
        annotation.iconName = BPKIconNameAirports;
    }

    BPKMapAnnotationView *annotationView = [[BPKMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ReuseIdentifier];
    annotationView.selected = previouslySelected;
    annotationView.selected = selected;

    UIView *wrapper = [[UIView alloc] initWithFrame:CGRectZero];
    [wrapper addSubview:annotationView];
    annotationView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [annotationView.centerXAnchor constraintEqualToAnchor:wrapper.centerXAnchor],
        [wrapper.bottomAnchor constraintEqualToAnchor:annotationView.bottomAnchor constant:BPKSpacingMd],
        [wrapper.widthAnchor constraintEqualToConstant:annotationWidth],
        [wrapper.heightAnchor constraintEqualToConstant:annotationHeight]
    ]];
    return wrapper;
}

-(UIView *)createMapAnnotationsWithIcons:(BOOL)icon {
    UIView *annotationView1 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:NO previouslySelected:NO selected:NO enabled:YES icon:icon];
    UIView *annotationView2 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:NO previouslySelected:NO selected:YES enabled:YES icon:icon];
    UIView *annotationView3 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:NO selected:NO enabled:YES icon:icon];
    UIView *annotationView4 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:YES selected:NO enabled:YES icon:icon];
    UIView *annotationView5 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:NO selected:YES enabled:YES icon:icon];
    UIView *annotationView6 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:NO selected:NO enabled:NO icon:icon];

    UIView *outerView = [[UIView alloc] initWithFrame:CGRectZero];

    [outerView addSubview:annotationView1];
    [outerView addSubview:annotationView2];
    [outerView addSubview:annotationView3];
    [outerView addSubview:annotationView4];
    [outerView addSubview:annotationView5];
    [outerView addSubview:annotationView6];

    outerView.translatesAutoresizingMaskIntoConstraints = NO;
    annotationView1.translatesAutoresizingMaskIntoConstraints = NO;
    annotationView2.translatesAutoresizingMaskIntoConstraints = NO;
    annotationView3.translatesAutoresizingMaskIntoConstraints = NO;
    annotationView4.translatesAutoresizingMaskIntoConstraints = NO;
    annotationView5.translatesAutoresizingMaskIntoConstraints = NO;
    annotationView6.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [annotationView1.leadingAnchor constraintEqualToAnchor:outerView.leadingAnchor],
        [annotationView1.topAnchor constraintEqualToAnchor:outerView.topAnchor],

        [annotationView2.leadingAnchor constraintEqualToAnchor:annotationView1.trailingAnchor],
        [annotationView2.topAnchor constraintEqualToAnchor:outerView.topAnchor],

        [annotationView3.leadingAnchor constraintEqualToAnchor:annotationView2.trailingAnchor],
        [annotationView3.topAnchor constraintEqualToAnchor:outerView.topAnchor],

        [annotationView4.leadingAnchor constraintEqualToAnchor:annotationView3.trailingAnchor],
        [annotationView4.topAnchor constraintEqualToAnchor:outerView.topAnchor],

        [annotationView5.leadingAnchor constraintEqualToAnchor:annotationView4.trailingAnchor],
        [annotationView5.topAnchor constraintEqualToAnchor:outerView.topAnchor],

        [annotationView6.leadingAnchor constraintEqualToAnchor:annotationView5.trailingAnchor],
        [annotationView6.topAnchor constraintEqualToAnchor:outerView.topAnchor],

        [outerView.trailingAnchor constraintEqualToAnchor:annotationView6.trailingAnchor],
        [outerView.bottomAnchor constraintEqualToAnchor:annotationView1.bottomAnchor]
    ]];
    return outerView;
}

- (void)testMapAnnotations {
    UIView *lightView = [self createMapAnnotationsWithIcons:NO];
    UIView *darkView = [self createMapAnnotationsWithIcons:NO];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}


- (void)testMapAnnotationsWithIcons {
    UIView *lightView = [self createMapAnnotationsWithIcons:YES];
    UIView *darkView = [self createMapAnnotationsWithIcons:YES];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

-(UIView *)createLongTitleCalloutViewWithIcon:(BOOL)icon {
    UIView *annotationView = [self
                              createMapAnnotationWithLabel:@"Callout with a super super super long title that goes on and on and on"
                              alwaysShowCallout:YES
                              previouslySelected:NO
                              selected:NO
                              enabled:YES
                              icon:icon
                              ];

    UIView *outerView = [[UIView alloc] initWithFrame:CGRectZero];

    [outerView addSubview:annotationView];

    outerView.translatesAutoresizingMaskIntoConstraints = NO;
    annotationView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [annotationView.leadingAnchor constraintEqualToAnchor:outerView.leadingAnchor constant:55],
        [annotationView.topAnchor constraintEqualToAnchor:outerView.topAnchor constant:10],

        [outerView.trailingAnchor constraintEqualToAnchor:annotationView.trailingAnchor constant:55],
        [outerView.bottomAnchor constraintEqualToAnchor:annotationView.bottomAnchor]
    ]];
    return outerView;
}

- (void)testLongTitleCalloutView {
    UIView *lightView = [self createLongTitleCalloutViewWithIcon:NO];
    UIView *darkView = [self createLongTitleCalloutViewWithIcon:NO];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

- (void)testLongTitleCalloutViewWithIcon {
    UIView *lightView = [self createLongTitleCalloutViewWithIcon:YES];
    UIView *darkView = [self createLongTitleCalloutViewWithIcon:YES];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
NS_ASSUME_NONNULL_END

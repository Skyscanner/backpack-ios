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

#import <Backpack/Map.h>

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import "BPKSnapshotTest.h"

NSString *const ReuseIdentifier = @"Annotation";
CGFloat const annotationHeight = 65;
CGFloat const annotationWidth = 100;

@interface BPKMapAnnotationSnapshotTest : FBSnapshotTestCase
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKMapAnnotationSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

-(UIView *)createMapAnnotationWithLabel:(NSString *)label alwaysShowCallout:(BOOL)alwaysShowCallout previouslySelected:(BOOL)previouslySelected selected:(BOOL)selected enabled:(BOOL)enabled {
    BPKMapAnnotation *annotation =  [[BPKMapAnnotation alloc] init];
    annotation.title = label;
    annotation.alwaysShowCallout = alwaysShowCallout;
    annotation.enabled = enabled;

    BPKMapAnnotationView *annotationView = [[BPKMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ReuseIdentifier];
    annotationView.selected = previouslySelected;
    annotationView.selected = selected;

    UIView *wrapper = [[UIView alloc] initWithFrame:CGRectZero];
    [wrapper addSubview:annotationView];
    annotationView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [annotationView.leadingAnchor constraintEqualToAnchor:wrapper.leadingAnchor constant:37],
        [annotationView.topAnchor constraintEqualToAnchor:wrapper.topAnchor constant:0],
        [annotationView.widthAnchor constraintEqualToConstant:50],
        [annotationView.heightAnchor constraintEqualToConstant:50],
        [wrapper.widthAnchor constraintEqualToConstant:annotationWidth],
        [wrapper.heightAnchor constraintEqualToConstant:annotationHeight]
    ]];
    return wrapper;
}

-(UIView *)createMapAnnotations {
    UIView *annotationView1 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:NO previouslySelected:NO selected:NO enabled:YES];
    UIView *annotationView2 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:NO previouslySelected:NO selected:YES enabled:YES];
    UIView *annotationView3 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:NO selected:NO enabled:YES];
    UIView *annotationView4 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:YES selected:NO enabled:YES];
    UIView *annotationView5 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:NO selected:YES enabled:YES];
    UIView *annotationView6 = [self createMapAnnotationWithLabel:@"Edinburgh" alwaysShowCallout:YES previouslySelected:NO selected:NO enabled:NO];

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
    UIView *lightView = [self createMapAnnotations];
    UIView *darkView = [self createMapAnnotations];

    BPKSnapshotVerifyViewLight(lightView, nil);
    BPKSnapshotVerifyViewDark(darkView, nil);
}

@end
NS_ASSUME_NONNULL_END

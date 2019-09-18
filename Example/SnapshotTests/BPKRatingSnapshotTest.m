/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

#import <Backpack/Rating.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKRatingSnapshotTest : FBSnapshotTestCase

@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKRatingSnapshotTest

- (void)setUp {
    [super setUp];
    self.recordMode = NO;
}

- (void)testRatingOutOfRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Capped";
    bpkRating.ratingValue = -1.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingOutOfRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Capped";
    bpkRating.ratingValue = 11.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Very low";
    bpkRating.ratingValue = 0.1;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Low";
    bpkRating.ratingValue = 5.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Medium";
    bpkRating.ratingValue = 6.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Medium-high";
    bpkRating.ratingValue = 7.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"High";
    bpkRating.ratingValue = 8.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"High";
    bpkRating.ratingValue = 9.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingOversized {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Meh";
    bpkRating.ratingValue = 4.7;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width * 3, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingUndersized {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"This don't fit yo!";
    bpkRating.ratingValue = 4.7;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowWithTheme {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"This don't fit yo!";
    bpkRating.ratingValue = 1.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumWithTheme {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"This don't fit yo!";
    bpkRating.ratingValue = 7.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighWithTheme {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"This don't fit yo!";
    bpkRating.ratingValue = 9.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeLowWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Very low";
    bpkRating.subtitle = @"Very low subtitle";
    bpkRating.ratingValue = 0.1;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeHighWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Low";
    bpkRating.subtitle = @"Low subtitle";
    bpkRating.ratingValue = 5.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeLowWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Medium";
    bpkRating.subtitle = @"Medium subtitle";
    bpkRating.ratingValue = 6.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeHighWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Medium-high";
    bpkRating.subtitle = @"Medium-high subtitle";
    bpkRating.ratingValue = 7.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeLowWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"High";
    bpkRating.subtitle = @"High subtitle";
    bpkRating.ratingValue = 8.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeHighWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"High";
    bpkRating.subtitle = @"High subtitle";
    bpkRating.ratingValue = 9.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingExtraSmall {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Extra small";
    bpkRating.subtitle = @"Extra small subtitle";
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeExtraSmall;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingSmall {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Small";
    bpkRating.subtitle = @"Small subtitle";
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeSmall;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingExtraBase {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Base";
    bpkRating.subtitle = @"Base subtitle";
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeBase;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingExtraLarge {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"Large";
    bpkRating.subtitle = @"Large subtitle";
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeLarge;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowWithThemeWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"This don't fit yo!";
    bpkRating.subtitle = @"This don't fit yo! subtitle";
    bpkRating.ratingValue = 1.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumWithThemeWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"This don't fit yo!";
    bpkRating.subtitle = @"This don't fit yo! subtitle";
    bpkRating.ratingValue = 7.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighWithThemeWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    bpkRating.title = @"This don't fit yo!";
    bpkRating.subtitle = @"This don't fit yo! subtitle";
    bpkRating.ratingValue = 9.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:CGSizeMake(1000, 1000)];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

@end

NS_ASSUME_NONNULL_END

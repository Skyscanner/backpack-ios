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

#import <Backpack/Rating.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BPKRatingSnapshotTest : FBSnapshotTestCase
@property(strong, nonatomic) BPKRatingTextDefinition *titleTextDefinition;
@property(strong, nonatomic) BPKRatingTextDefinition *subTitleTextDefinition;
@end

NS_ASSUME_NONNULL_BEGIN
@implementation BPKRatingSnapshotTest

- (void)setUp {
    [super setUp];
    self.titleTextDefinition = [[BPKRatingTextDefinition alloc] initWithHighRatingText:@"High" mediumRatingText:@"Medium" lowRatingText:@"Low"];
    self.subTitleTextDefinition = [[BPKRatingTextDefinition alloc] initWithHighRatingText:@"High subtitle"
                                                                         mediumRatingText:@"Medium subtitle"
                                                                            lowRatingText:@"Low subtitle"];
    self.recordMode = NO;
}

- (void)testRatingOutOfRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Capped";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = -1.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingOutOfRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Capped";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 11.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Very low";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 0.1;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Low";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 5.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 6.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium-high";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 7.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeLow {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 8.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 9.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingOversized {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Meh";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 4.7;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width * 3, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingUndersized {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"This don't fit yo!";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 4.7;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowWithTheme {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"This don't fit yo!";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 1.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumWithTheme {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"This don't fit yo!";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 7.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighWithTheme {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"This don't fit yo!";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 9.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeLowWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Very low";
    self.subTitleTextDefinition.lowRatingText = @"Very low subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 0.1;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeHighWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Low";
    self.subTitleTextDefinition.lowRatingText = @"Low subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 5.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeLowWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium";
    self.subTitleTextDefinition.mediumRatingText = @"Medium subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 6.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeHighWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium-high";
    self.subTitleTextDefinition.mediumRatingText = @"Medium-high subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 7.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeLowWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    self.subTitleTextDefinition.highRatingText = @"High subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeHighWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    self.subTitleTextDefinition.highRatingText = @"High subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 9.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingPillHighRangeHigh {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.layout = BPKRatingLayoutHorizontalPill;
    bpkRating.ratingValue = 9.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingPillHighRangeHighWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    self.subTitleTextDefinition.highRatingText = @"High subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.layout = BPKRatingLayoutHorizontalPill;
    bpkRating.ratingValue = 9.9;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingExtraSmall {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Extra small";
    self.subTitleTextDefinition.highRatingText = @"Extra small subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeExtraSmall;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingSmall {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Small";
    self.subTitleTextDefinition.highRatingText = @"Small subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeSmall;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingExtraBase {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Base";
    self.subTitleTextDefinition.highRatingText = @"Base subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeBase;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingExtraLarge {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Large";
    self.subTitleTextDefinition.highRatingText = @"Large subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.size = BPKRatingSizeLarge;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowWithThemeWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"This don't fit yo!";
    self.subTitleTextDefinition.lowRatingText = @"This don't fit yo! subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 1.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumWithThemeWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"This don't fit yo!";
    self.subTitleTextDefinition.mediumRatingText = @"This don't fit yo! subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 7.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighWithThemeWithSubtitle {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"This don't fit yo!";
    self.subTitleTextDefinition.highRatingText = @"This don't fit yo! subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 9.0;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingOutOfRangeLowVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Capped";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = -1.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingOutOfRangeHighVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Capped";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 11.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeLowVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Very low";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 0.1;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeHighVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Low";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 5.9;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeLowVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 6.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeHighVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium-high";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 7.9;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeLowVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeHighVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 9.9;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingOversizedVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Meh";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 4.7;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width * 3, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingUndersizedVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"This don't fit yo!";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.ratingValue = 4.7;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeLowWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Very low";
    self.subTitleTextDefinition.lowRatingText = @"Very low subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 0.1;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowRangeHighWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"Low";
    self.subTitleTextDefinition.lowRatingText = @"Low subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 5.9;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeLowWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium";
    self.subTitleTextDefinition.mediumRatingText = @"Medium subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 6.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumRangeHighWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"Medium-high";
    self.subTitleTextDefinition.mediumRatingText = @"Medium-high subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 7.9;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeLowWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    self.subTitleTextDefinition.highRatingText = @"High subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighRangeHighWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"High";
    self.subTitleTextDefinition.highRatingText = @"High subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 9.9;
    bpkRating.layout = BPKRatingLayoutVertical;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingExtraSmallVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Extra small";
    self.subTitleTextDefinition.highRatingText = @"Extra small subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    bpkRating.size = BPKRatingSizeExtraSmall;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingSmallVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Small";
    self.subTitleTextDefinition.highRatingText = @"Small subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    bpkRating.size = BPKRatingSizeSmall;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingBaseVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Base";
    self.subTitleTextDefinition.highRatingText = @"Base subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    bpkRating.size = BPKRatingSizeBase;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLargeVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"Large";
    self.subTitleTextDefinition.highRatingText = @"Large subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 8.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    bpkRating.size = BPKRatingSizeLarge;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingLowWithThemeWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.lowRatingText = @"This don't fit yo!";
    self.subTitleTextDefinition.lowRatingText = @"This don't fit yo! subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 1.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingMediumWithThemeWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.mediumRatingText = @"This don't fit yo!";
    self.subTitleTextDefinition.mediumRatingText = @"This don't fit yo! subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 7.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

- (void)testRatingHighWithThemeWithSubtitleVertical {
    BPKRating *bpkRating = [[BPKRating alloc] initWithFrame:CGRectZero];
    self.titleTextDefinition.highRatingText = @"This don't fit yo!";
    self.subTitleTextDefinition.highRatingText = @"This don't fit yo! subtitle";
    bpkRating.title = self.titleTextDefinition;
    bpkRating.subtitle = self.subTitleTextDefinition;
    bpkRating.ratingValue = 9.0;
    bpkRating.layout = BPKRatingLayoutVertical;
    bpkRating.lowRatingColor = UIColor.purpleColor;
    bpkRating.mediumRatingColor = UIColor.orangeColor;
    bpkRating.highRatingColor = UIColor.cyanColor;
    CGSize fittingSize = [bpkRating systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    bpkRating.frame = CGRectMake(0.0, 0.0, fittingSize.width / 1.5, fittingSize.height);
    FBSnapshotVerifyView(bpkRating, nil);
}

@end

NS_ASSUME_NONNULL_END

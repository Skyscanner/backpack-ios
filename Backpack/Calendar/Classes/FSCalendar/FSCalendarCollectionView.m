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

#import "FSCalendarCollectionView.h"
#import "FSCalendarConstants.h"
#import "FSCalendarExtensions.h"

@interface FSCalendarCollectionView ()

- (void)commonInit;

@end

@implementation FSCalendarCollectionView

@synthesize scrollsToTop = _scrollsToTop, contentInset = _contentInset;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.scrollsToTop = NO;
    self.contentInset = UIEdgeInsetsZero;
    if (@available(iOS 10.0, *))
        self.prefetchingEnabled = NO;
    if (@available(iOS 11.0, *))
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.internalDelegate && [self.internalDelegate respondsToSelector:@selector(collectionViewDidFinishLayoutSubviews:)]) {
        [self.internalDelegate collectionViewDidFinishLayoutSubviews:self];
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:UIEdgeInsetsZero];
    if (contentInset.top) {
        self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + contentInset.top);
    }
}

- (void)setScrollsToTop:(BOOL)scrollsToTop {
    [super setScrollsToTop:NO];
}

@end

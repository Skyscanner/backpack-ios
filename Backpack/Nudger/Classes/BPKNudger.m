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

#import "BPKNudger.h"

#import <Backpack/Button.h>
#import <Backpack/Common.h>
#import <Backpack/Icon.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

#import "BPKNudgerConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

const double BPKNudgerDefaultValue = 0;
const double BPKNudgerDefaultMinimumValue = 0;
const double BPKNudgerDefaultMaximumValue = 100;
const double BPKNudgerDefaultStepValue = 1;

@interface BPKNudger()
@property(nonatomic, strong) BPKNudgerConfiguration *configuration;

@property(nonatomic, strong, readonly) UIStackView *stackView;
@property(nonatomic, strong, readonly) BPKButton *decrementButton;
@property(nonatomic, strong, readonly) BPKLabel *label;
@property(nonatomic, strong, readonly) BPKButton *incrementButton;

@property(nonatomic, assign, readonly) BOOL canIncrement;
@property(nonatomic, assign, readonly) BOOL canDecrement;
@property(nonatomic, assign, readonly) CGFloat minimumLabelWidth;
@end

@implementation BPKNudger
@synthesize stackView = _stackView,
      decrementButton = _decrementButton,
                label = _label,
      incrementButton = _incrementButton;

- (instancetype)initWithConfiguration:(BPKNudgerConfiguration *)configuration {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.configuration = configuration;

        [self setUp];
    }

    return self;
}

-(CGFloat)minimumLabelWidth {
    // Reserve space for 2 digits. 9 is one of the widest digits
    // in Relative so 99 is one of the widest two digit numbers possible
    CGFloat width =  [@"99" sizeWithAttributes:@{NSFontAttributeName: self.label.font}].width;

    // Round the value up to the nearest value that aligns to our spacing grid:
    width = ceil(width/BPKSpacingSm) * BPKSpacingSm;

    return width;
}

- (void)setUp {
    _value = BPKNudgerDefaultValue;
    _minimumValue = BPKNudgerDefaultMinimumValue;
    _maximumValue = BPKNudgerDefaultMaximumValue;
    _stepValue = BPKNudgerDefaultStepValue;

    [self addSubview:self.stackView];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;

    CGFloat minWidth = self.minimumLabelWidth;
    [NSLayoutConstraint activateConstraints:@[
        [self.topAnchor constraintEqualToAnchor:self.stackView.topAnchor],
        [self.leadingAnchor constraintEqualToAnchor:self.stackView.leadingAnchor],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.label.widthAnchor constraintGreaterThanOrEqualToConstant:minWidth],
    ]];
    self.accessibilityTraits = UIAccessibilityTraitAdjustable;
    self.isAccessibilityElement = YES;

    [self updateDisplay];
}

#pragma mark - Properties

- (UIStackView *)stackView {
    BPKAssertMainThread();
    if (_stackView) {
        return _stackView;
    }

    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = BPKSpacingMd;

    [stackView addArrangedSubview:self.decrementButton];
    [stackView addArrangedSubview:self.label];
    [stackView addArrangedSubview:self.incrementButton];

    _stackView = stackView;

    return _stackView;
}

- (BPKButton *)decrementButton {
    BPKAssertMainThread();
    if (_decrementButton) {
        return _decrementButton;
    }

    BPKButton *decrementButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleSecondary];
    [decrementButton setImage:[BPKIcon smallTemplateIconNamed:BPKSmallIconNameMinus]];

    _decrementButton = decrementButton;
    [_decrementButton addTarget:self action:@selector(didTapDecrement:) forControlEvents:UIControlEventTouchUpInside];

    return _decrementButton;
}

- (BPKLabel *)label {
    BPKAssertMainThread();
    if (_label) {
        return _label;
    }

    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    label.textAlignment = NSTextAlignmentCenter;

    _label = label;
    return _label;
}

- (BPKButton *)incrementButton {
    BPKAssertMainThread();
    if (_incrementButton) {
        return _incrementButton;
    }

    BPKButton *incrementButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleSecondary];
    [incrementButton setImage:[BPKIcon smallTemplateIconNamed:BPKSmallIconNamePlus]];

    _incrementButton = incrementButton;
    [_incrementButton addTarget:self action:@selector(didTapIncrement:) forControlEvents:UIControlEventTouchUpInside];

    return _incrementButton;
}

#pragma mark - Actions

- (void)didTapDecrement:(BPKButton *)sender {
    [self decrementValue];
}

- (void)didTapIncrement:(BPKButton *)sender {
    [self incrementValue];
}


#pragma mark - Setters / Logic

- (void)decrementValue {
    self.value -= self.stepValue;
    [self sendChangeEvent];
    [self announceCurrentValue];
}

- (BOOL)canDecrement {
    return (self.value - self.stepValue) >= self.minimumValue;
}

- (void)incrementValue {
    self.value += self.stepValue;
    [self sendChangeEvent];
    [self announceCurrentValue];
}

- (BOOL)canIncrement {
    return (self.value + self.stepValue) <= self.maximumValue;
}

- (void)setValue:(double)value {
    if (value != _value) {
        if (value < self.minimumValue || value > self.maximumValue) {
            return;
        }

        _value = value;
        [self updateDisplay];
    }
}

- (void)setMinimumValue:(double)minimumValue {
    if (minimumValue > self.maximumValue) {
        NSString *reason = [NSString stringWithFormat:@"Cannot set minimumValue %f when maximumValue is %f",
                            minimumValue, self.maximumValue];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
    }

    _minimumValue = minimumValue;
    self.value = MAX(self.value, minimumValue);

    [self updateDisplay];
}

- (void)setMaximumValue:(double)maximumValue {
    if (maximumValue < self.minimumValue) {
        NSString *reason = [NSString stringWithFormat:@"Cannot set maximumValue %f when minimumValue is %f",
                            maximumValue, self.minimumValue];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
    }

    _maximumValue = maximumValue;
    self.value = MIN(self.value, maximumValue);
    [self updateDisplay];
}

- (void)setStepValue:(double)stepValue {
    if (stepValue <= 0) {
        NSString *reason = [NSString stringWithFormat:@"Cannot set stepValue %f. Value needs to be greater than 0",
                            stepValue];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
    }

    _stepValue = stepValue;
    [self updateDisplay];
}



- (void)updateDisplay {
    self.label.text = self.configuration.labelFormatter(self.value);
    NSString *newLabel = self.configuration.accessibilityLabelFormatter(self.value);
    self.accessibilityLabel = newLabel;
    self.decrementButton.enabled = self.canDecrement;
    self.incrementButton.enabled = self.canIncrement;
}

- (void)sendChangeEvent {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)announceCurrentValue {
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.accessibilityLabel);
}

#pragma mark - UIAccessibilityAdjustable

- (void)accessibilityDecrement {
    if (self.canDecrement) {
        [self decrementValue];
    } else {
        [self announceCurrentValue];
    }
}

- (void)accessibilityIncrement {
    if (self.canIncrement) {
        [self incrementValue];
    } else {
        [self announceCurrentValue];
    }
}

@end
NS_ASSUME_NONNULL_END

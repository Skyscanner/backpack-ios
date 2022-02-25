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

#import "BPKToast.h"
#import <Backpack/Color.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

NSString *const ToastAccessibilityIdentifier = @"toastView";

@interface BPKToast () <MBProgressHUDDelegate>
@property(nonatomic, strong) MBProgressHUD *hud;
@end

@implementation BPKToast

#pragma mark - Initializers
+ (instancetype)showToastAddedTo:(UIView *)view animated:(BOOL)animated accessibilityAnnouncement:(nonnull NSString *)accessibilityAnnouncement {
    BPKToast *toast = [[BPKToast alloc] initWithView:view animated:animated accessibilityAnnouncement:accessibilityAnnouncement];
    [toast postAccessibilityNotification];
    return toast;
}

- (instancetype)initWithView:(UIView *)view animated:(BOOL)animated accessibilityAnnouncement:(nonnull NSString *)accessibilityAnnouncement {
    if (self = [super initWithFrame:view.bounds]) {
        self.hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
        _accessibilityAnnouncement = [accessibilityAnnouncement copy];
        [self setupHUD];
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view accessibilityAnnouncement:(nonnull NSString *)accessibilityAnnouncement {
    if (self = [super initWithFrame:view.bounds]) {
        self.hud = [[MBProgressHUD alloc] initWithView:self];
        _accessibilityAnnouncement = [accessibilityAnnouncement copy];
        [self setupHUD];
        [self addSubview:self.hud];
    }
    return self;
}

#pragma mark - Public methods
- (void)show:(BOOL)animated {
    [self.hud showAnimated:animated];
    [self postAccessibilityNotification];
}

- (void)hide:(BOOL)animated {
    [self.hud hideAnimated:animated];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self.hud hideAnimated:animated afterDelay:delay];
}

#pragma mark - Property overrides
- (void)setMode:(BPKToastMode)mode {
    if (_mode != mode) {
        _mode = mode;
        switch (mode) {
        case BPKToastModeText:
            self.hud.mode = MBProgressHUDModeText;
            break;
        case BPKToastModeIndeterminate:
            self.hud.mode = MBProgressHUDModeIndeterminate;
            break;
        }
    }
}

- (void)setAccessibilityAnnouncement:(nonnull NSString *)accessibilityAnnouncement {
    if (accessibilityAnnouncement != _accessibilityAnnouncement) {
        _accessibilityAnnouncement = [accessibilityAnnouncement copy];

        [self postAccessibilityNotification];
    }
}

- (void)setLabelText:(NSString *)labelText {
    if (_hud.label.text != labelText) {
        _hud.label.text = labelText;
    }
}

- (void)setDetailsLabelText:(NSString *)detailsLabelText {
    if (_hud.detailsLabel.text != detailsLabelText) {
        _hud.detailsLabel.text = detailsLabelText;
    }
}

- (void)setRemoveFromSuperViewOnHide:(BOOL)removeFromSuperViewOnHide {
    if (_hud.removeFromSuperViewOnHide != removeFromSuperViewOnHide) {
        _hud.removeFromSuperViewOnHide = removeFromSuperViewOnHide;
    }
}

- (void)setMinShowTime:(float)minShowTime {
    if (_hud.minShowTime != minShowTime) {
        _hud.minShowTime = minShowTime;
    }
}

- (NSString *)labelText {
    return self.hud.label.text;
}

- (NSString *)detailsLabelText {
    return self.hud.detailsLabel.text;
}

- (BOOL)removeFromSuperViewOnHide {
    return self.hud.removeFromSuperViewOnHide;
}

- (float)minShowTime {
    return self.hud.minShowTime;
}

#pragma mark - HUD delegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (self.hud.removeFromSuperViewOnHide) {
        [self removeFromSuperview];
    }
}

#pragma mark - Private methods

- (void)setupHUD {
    self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.backgroundColor = [[BPKColor dynamicColorWithLightVariant:BPKColor.skyGray
                                                                     darkVariant:BPKColor.blackTint03] colorWithAlphaComponent:0.85];
    self.hud.contentColor = BPKColor.white;
    self.hud.delegate = self;
    self.hud.accessibilityIdentifier = ToastAccessibilityIdentifier;
    self.hud.isAccessibilityElement = NO;
    self.hud.label.isAccessibilityElement = NO;
    self.hud.detailsLabel.isAccessibilityElement = NO;
    self.hud.accessibilityViewIsModal = YES;
}

- (void)postAccessibilityNotification {
    NSAttributedString *announcement = [[NSAttributedString alloc] initWithString:self.accessibilityAnnouncement
                                                                       attributes:@{UIAccessibilitySpeechAttributeQueueAnnouncement: @YES}];
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, announcement);
}

@end
NS_ASSUME_NONNULL_END

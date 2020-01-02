/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKButtonsViewController.h"
#import "BPKExampleAppTitleAttributes.h"
#import "Backpack_Native-Swift.h"

#import <Backpack/Color.h>
#import <Backpack/DarkMode.h>
#import <Backpack/Icon.h>
#import <Backpack/Label.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKButtonsViewController ()
@property(strong, nonatomic) IBOutletCollection(UIView) NSArray *contentViews;
@property(strong, nonatomic) IBOutletCollection(BPKLabel) NSArray *storyHeadings;
@property(weak, nonatomic) IBOutlet BPKButton *defaultTextButton;
@property(weak, nonatomic) IBOutlet BPKButton *defaultIconOnlyButton;
@property(weak, nonatomic) IBOutlet BPKButton *defaultTrailingIconButton;
@property(weak, nonatomic) IBOutlet BPKButton *defaultLeadingIconButton;
@property(weak, nonatomic) IBOutlet BPKButton *defaultDisabledButton;
@property(weak, nonatomic) IBOutlet BPKButton *defaultLoadingButton;
@property(weak, nonatomic) IBOutlet BPKButton *defaultLoadingIconOnlyButton;
@property(weak, nonatomic) IBOutlet BPKButton *defaultLoadingTitleOnlyButton;

@property(weak, nonatomic) IBOutlet BPKButton *largeTextButton;
@property(weak, nonatomic) IBOutlet BPKButton *largeIconOnlyButton;
@property(weak, nonatomic) IBOutlet BPKButton *largeTrailingIconButton;
@property(weak, nonatomic) IBOutlet BPKButton *largeLeadingIconButton;
@property(weak, nonatomic) IBOutlet BPKButton *largeDisabledButton;
@property(weak, nonatomic) IBOutlet BPKButton *largeLoadingButton;
@property(weak, nonatomic) IBOutlet BPKButton *largeLoadingIconOnlyButton;
@property(weak, nonatomic) IBOutlet BPKButton *largeLoadingTitleOnlyButton;
@property(assign, nonatomic) BOOL isOutlineSectionWithLightStyle;

- (void)setupButton:(BPKButton *)button image:(UIImage *_Nullable)image title:(NSString *_Nullable)title;
@property(nonatomic, getter=isRTL, readonly) BOOL isRTL;
@end

@implementation BPKButtonsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

#if __BPK_DARK_MODE_SUPPORTED
    if (ThemeHelpers.overrideUserInterfaceStyle) {
        if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }
    }
#endif

    [self setupButtons];
}

- (void)setupButtons {
    if (self.isOutlineSectionWithLightStyle) {
        for (UIView *contentView in self.contentViews) {
            [contentView setBackgroundColor:BPKColor.skyBlueShade03];
        }
        for (UILabel *storyHeading in self.storyHeadings) {
            [storyHeading setTextColor:BPKColor.white];
        }
    }

    UIImage *smallLongArrowIcon = self.isRTL ? [BPKIcon templateIconNamed:@"long-arrow-left" size:BPKIconSizeSmall]
                                             : [BPKIcon templateIconNamed:@"long-arrow-right" size:BPKIconSizeSmall];
    [self setupButton:self.defaultTextButton image:nil title:@"Search Flights"];
    [self setupButton:self.defaultLoadingButton image:smallLongArrowIcon title:@"Loading"];
    [self setupButton:self.defaultTrailingIconButton image:smallLongArrowIcon title:@"With icon"];
    [self setupButton:self.defaultLeadingIconButton image:smallLongArrowIcon title:@"With icon"];
    [self setupButton:self.defaultIconOnlyButton image:smallLongArrowIcon title:nil];
    [self setupButton:self.defaultLoadingIconOnlyButton image:smallLongArrowIcon title:nil];

    UIImage *largeLongArrowIcon = [BPKIcon templateIconNamed:@"long-arrow-right" size:BPKIconSizeLarge];

    [self setupButton:self.largeTextButton image:nil title:@"Button"];
    [self setupButton:self.largeTrailingIconButton image:largeLongArrowIcon title:@"With icon"];
    [self setupButton:self.largeLeadingIconButton image:largeLongArrowIcon title:@"With icon"];
    [self setupButton:self.largeIconOnlyButton image:largeLongArrowIcon title:nil];
    [self setupButton:self.largeLoadingIconOnlyButton image:largeLongArrowIcon title:nil];
    [self setupButton:self.largeLoadingButton image:largeLongArrowIcon title:@"Loading"];

    self.defaultTextButton.style = self.style;
    self.defaultDisabledButton.style = self.style;
    self.defaultIconOnlyButton.style = self.style;
    self.defaultTrailingIconButton.style = self.style;
    self.defaultLeadingIconButton.style = self.style;
    self.defaultLoadingIconOnlyButton.style = self.style;
    self.defaultLoadingTitleOnlyButton.style = self.style;
    self.defaultLoadingButton.style = self.style;
    self.defaultLoadingButton.isLoading = YES;
    self.defaultLoadingIconOnlyButton.isLoading = YES;
    self.defaultLoadingTitleOnlyButton.isLoading = YES;

    self.largeTextButton.style = self.style;
    self.largeDisabledButton.style = self.style;
    self.largeIconOnlyButton.style = self.style;
    self.largeTrailingIconButton.style = self.style;
    self.largeLeadingIconButton.style = self.style;
    self.largeLoadingIconOnlyButton.style = self.style;
    self.largeLoadingTitleOnlyButton.style = self.style;
    self.largeLoadingButton.style = self.style;
    self.largeLoadingButton.isLoading = YES;
    self.largeLoadingIconOnlyButton.isLoading = YES;
    self.largeLoadingTitleOnlyButton.isLoading = YES;
}

- (void)setupButton:(BPKButton *)button image:(UIImage *_Nullable)image title:(NSString *_Nullable)title {
    [button setImage:image];
    [button setTitle:title];
}

- (BOOL)isRTL {
    return [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.view.semanticContentAttribute] ==
           UIUserInterfaceLayoutDirectionRightToLeft;
}

- (IBAction)switchLoadingState:(UISwitch *)sender {
    self.defaultLoadingTitleOnlyButton.isLoading = sender.on;
    self.defaultLoadingIconOnlyButton.isLoading = sender.on;
    self.defaultLoadingButton.isLoading = sender.on;
    self.largeLoadingIconOnlyButton.isLoading = sender.on;
    self.largeLoadingTitleOnlyButton.isLoading = sender.on;
    self.largeLoadingButton.isLoading = sender.on;
}

- (BOOL)isOutlineSectionWithLightStyle {
#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        return (self.style == BPKButtonStyleOutline &&
                self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight);
    }
#endif

    return (self.style == BPKButtonStyleOutline);
}

@end
NS_ASSUME_NONNULL_END

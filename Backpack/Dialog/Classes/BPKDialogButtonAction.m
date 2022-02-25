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

#import "BPKDialogButtonAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKDialogButtonAction ()
@property(nonatomic, assign) BPKButtonStyle style;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) BPKDialogButtonActionHandler handler;

- (instancetype _Nonnull)initWithButtonStyle:(BPKButtonStyle)style title:(NSString *)title actionHandler:(BPKDialogButtonActionHandler)handler;
@end

@implementation BPKDialogButtonAction

- (instancetype _Nonnull)initWithButtonStyle:(BPKButtonStyle)style title:(NSString *)title actionHandler:(BPKDialogButtonActionHandler)handler {
    self = [super init];

    if (self) {
        self.style = style;
        self.title = title;
        self.handler = handler;
    }

    return self;
}

+ (instancetype _Nonnull)actionWithTitle:(NSString *)title style:(BPKButtonStyle)style handler:(BPKDialogButtonActionHandler)handler {
    return [[self alloc] initWithButtonStyle:style title:title actionHandler:handler];
}

@end
NS_ASSUME_NONNULL_END

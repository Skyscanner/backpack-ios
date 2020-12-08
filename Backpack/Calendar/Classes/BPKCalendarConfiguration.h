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

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCalendarConfiguration` is a subclass of `NSObject` containing properties which the calendar will use when
 * rendering.
 */
@interface BPKCalendarConfiguration : NSObject

/**
 * The class that will be used for individual cells.
 */
@property(nonnull, readonly) Class cellClass;

/**
 * The class that will be used to represent additional cell-data.
 */
@property(nonnull, readonly) Class cellDataClass;

/**
 * The height that cells should be rendered.
 */
@property(readonly) CGFloat rowHeight;

/**
 * Creates a `BPKCalendarConfiguration` with the specific classes.
 *
 * @param cellClass Class to use for individual cells.
 * @param cellDataClass Class used to represent additional cell-data.
 * @param rowHeight The height that calendar rows should be rendered,.
 * @return `BPKCalendarConfiguration` instance.
 */
- (instancetype)initWithCellClass:(Class)cellClass cellDataClass:(Class)cellDataClass rowHeight:(CGFloat)rowHeight;

/**
 * Creates a `BPKCalendarConfiguration` with the specific classes.
 *
 * @param cellClass Class to use for individual cells.
 * @param cellDataClass Class used to represent additional cell-data.
 * @return `BPKCalendarConfiguration` instance.
 */
- (instancetype)initWithCellClass:(Class)cellClass cellDataClass:(Class)cellDataClass;

@end

NS_ASSUME_NONNULL_END

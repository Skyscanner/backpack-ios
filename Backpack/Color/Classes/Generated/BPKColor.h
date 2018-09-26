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
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class UIColor;
/**
 * BPKColor is the entry point for the Backpack color palette. It expose the whole palette
 * as static methods.
*/
NS_SWIFT_NAME(Color) @interface BPKColor: NSObject

///-----------------------
/// @name Colors
///-----------------------

/**
 * The `blue100` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #cbeef5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue100;

/**
 * The `blue200` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #b0e4eeff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue200;

/**
 * The `blue300` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #7fd7e8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue300;

/**
 * The `blue400` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #40c4dfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue400;

/**
 * The `blue50` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #e1f4f8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue50;

/**
 * The `blue500` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #00b2d6ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue500;

/**
 * The `blue600` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #009dbdff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue600;

/**
 * The `blue700` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #008ca8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue700;

/**
 * The `blue800` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #00758cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue800;

/**
 * The `blue900` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #005567ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * blue900;

/**
 * The `gray100` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #e6e4ebff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray100;

/**
 * The `gray200` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ccc9d4ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray200;

/**
 * The `gray300` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #b2aebdff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray300;

/**
 * The `gray400` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #9a95a7ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray400;

/**
 * The `gray50` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #f3f2f5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray50;

/**
 * The `gray500` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #817b8fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray500;

/**
 * The `gray600` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #696179ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray600;

/**
 * The `gray700` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #524c61ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray700;

/**
 * The `gray800` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #3b344bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray800;

/**
 * The `gray900` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #252033ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * gray900;

/**
 * The `green100` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #cbf5e2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green100;

/**
 * The `green200` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #afedd1ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green200;

/**
 * The `green300` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #80e8b9ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green300;

/**
 * The `green400` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #40de97ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green400;

/**
 * The `green50` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #dff7ecff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green50;

/**
 * The `green500` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #00d775ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green500;

/**
 * The `green600` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #00bd68ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green600;

/**
 * The `green700` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #00a85dff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green700;

/**
 * The `green800` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #008c4dff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green800;

/**
 * The `green900` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #006638ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * green900;

/**
 * The `pink100` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffbfd7ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink100;

/**
 * The `pink200` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ff94bbff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink200;

/**
 * The `pink300` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ff73a6ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink300;

/**
 * The `pink400` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ff619bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink400;

/**
 * The `pink50` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #fde4edff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink50;

/**
 * The `pink500` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #fa488aff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink500;

/**
 * The `pink600` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #d92b6bff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink600;

/**
 * The `pink700` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #c50f52ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink700;

/**
 * The `pink800` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #b00c48ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink800;

/**
 * The `pink900` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #94053aff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * pink900;

/**
 * The `primaryGradientLight` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #02ddd8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * primaryGradientLight;

/**
 * The `red100` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffd6d5ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red100;

/**
 * The `red200` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffbbbaff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red200;

/**
 * The `red300` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ff9694ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red300;

/**
 * The `red400` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #fe7471ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red400;

/**
 * The `red50` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #fcf2f2ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red50;

/**
 * The `red500` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ff5452ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red500;

/**
 * The `red600` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #eb423fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red600;

/**
 * The `red700` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #de322fff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red700;

/**
 * The `red800` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #cc1f1dff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red800;

/**
 * The `red900` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #a80300ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * red900;

/**
 * The `white` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffffffff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * white;

/**
 * The `yellow100` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #fff3cfff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow100;

/**
 * The `yellow200` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffecb8ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow200;

/**
 * The `yellow300` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffe18cff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow300;

/**
 * The `yellow400` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffcf4aff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow400;

/**
 * The `yellow50` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #fff9e6ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow50;

/**
 * The `yellow500` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #ffbb00ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow500;

/**
 * The `yellow600` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #f0b000ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow600;

/**
 * The `yellow700` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #e1a500ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow700;

/**
 * The `yellow800` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #c28e00ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow800;

/**
 * The `yellow900` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #9c7200ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * yellow900;

/**
 * The `shadowLgColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #252033ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowLgColor;

/**
 * The `shadowSmColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #252033ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowSmColor;

/**
 * The `shadowXlColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #252033ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * shadowXlColor;

/**
 * The `touchableOverlayColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #252033ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * touchableOverlayColor;

/**
 * The `underlayColor` color from the Backpack palette.
 *
 * <div style="width: 100px; height: 100px; background: #252033ff; box-shadow: 0px 1px 3px 0px rgba(37,32,31,.3); border-radius: 6px;"></div>
*/
@property(nonatomic, class, readonly) UIColor * underlayColor;

+ (UIColor *)clear;

@end
NS_ASSUME_NONNULL_END

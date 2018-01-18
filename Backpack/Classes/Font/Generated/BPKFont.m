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
#import "BPKFont.h"

@implementation BPKFont

+ (UIFont *)textXs {
    return [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
}

+ (UIFont *)textXsEmphasized {
    return [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
}

+ (UIFont *)textSm {
    return [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
}

+ (UIFont *)textSmEmphasized {
    return [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
}

+ (UIFont *)textBase {
    return [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
}

+ (UIFont *)textBaseEmphasized {
    return [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
}

+ (UIFont *)textLg {
    return [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
}

+ (UIFont *)textLgEmphasized {
    return [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
}

+ (UIFont *)textXl {
    return [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
}

+ (UIFont *)textXlEmphasized {
    return [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
}


@end

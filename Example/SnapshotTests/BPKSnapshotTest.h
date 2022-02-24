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

#import <UIKit/UIKit.h>

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <FBSnapshotTestCase/FBSnapshotTestCasePlatform.h>
#import <FBSnapshotTestCase/FBSnapshotTestController.h>

#import <Backpack/DarkMode.h>

#define BPKVerifySnapshotOS()                                                                                                                        \
    {                                                                                                                                                \
        NSString *correctDeviceName = @"iPhone 8";                                                                                                   \
        int correctMajorVersion = 15;                                                                                                                \
        int correctMinorVersion = 2;                                                                                                                 \
        NSString *deviceName = [[UIDevice currentDevice] name];                                                                                      \
        NSOperatingSystemVersion deviceOSVersion = [[NSProcessInfo processInfo] operatingSystemVersion];                                             \
        BOOL validDevice = [deviceName isEqual:correctDeviceName];                                                                                   \
        if (deviceOSVersion.majorVersion != correctMajorVersion) {                                                                                   \
            validDevice = NO;                                                                                                                        \
        }                                                                                                                                            \
        if (deviceOSVersion.minorVersion != correctMinorVersion) {                                                                                   \
            validDevice = NO;                                                                                                                        \
        }                                                                                                                                            \
                                                                                                                                                     \
        NSString *correctOSVersion = [NSString stringWithFormat:@"%d.%d", correctMajorVersion, correctMinorVersion];                                 \
        NSString *actualOSVersion = [NSString stringWithFormat:@"%ld.%ld", deviceOSVersion.majorVersion, deviceOSVersion.minorVersion];              \
        XCTAssertTrue(validDevice, @"Snapshot tests are only valid on an %@ running iOS %@. Device was %@ running iOS %@.", correctDeviceName,       \
                      correctOSVersion, deviceName, actualOSVersion);                                                                                \
    }

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewLight(view__, identifier__)                                                                                             \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        NSString *identifier = @"light-mode";                                                                                                        \
        if (identifier__ != nil) {                                                                                                                   \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                                                             \
        }                                                                                                                                            \
        view__.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;                                                                               \
        FBSnapshotVerifyView(view__, identifier);                                                                                                    \
    }
#else
#define BPKSnapshotVerifyViewLight(view__, identifier__)                                                                                             \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        FBSnapshotVerifyView(view__, identifier__);                                                                                                  \
    }
#endif

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewDark(view__, identifier__)                                                                                              \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        NSString *identifier = @"dark-mode";                                                                                                         \
        if (identifier__ != nil) {                                                                                                                   \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                                                             \
        }                                                                                                                                            \
        view__.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;                                                                                \
        FBSnapshotVerifyView(view__, identifier);                                                                                                    \
    }
#else
#define BPKSnapshotVerifyViewDark(view__, identifier__)                                                                                              \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        FBSnapshotVerifyView(view__, identifier__);                                                                                                  \
    }
#endif

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewLightWithOptions(view__, identifier__, suffixes__, tolerance__)                                                         \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        NSString *identifier = @"light-mode";                                                                                                        \
        if (identifier__ != nil) {                                                                                                                   \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                                                             \
        }                                                                                                                                            \
                                                                                                                                                     \
        view__.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;                                                                               \
        FBSnapshotVerifyViewWithOptions(view__, identifier, suffixes__, tolerance__);                                                                \
    }
#else
#define BPKSnapshotVerifyViewLightWithOptions(view__, identifier__, suffixes__, tolerance__)                                                         \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        FBSnapshotVerifyViewWithOptions(view__, identifier__, suffixes__, tolerance__);                                                              \
    }
#endif

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewDarkWithOptions(view__, identifier__, suffixes__, tolerance__)                                                          \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        NSString *identifier = @"dark-mode";                                                                                                         \
        if (identifier__ != nil) {                                                                                                                   \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                                                             \
        }                                                                                                                                            \
        view__.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;                                                                                \
        FBSnapshotVerifyViewWithOptions(view__, identifier, suffixes__, tolerance__);                                                                \
    }
#else
#define BPKSnapshotVerifyViewDarkWithOptions(view__, identifier__, suffixes__, tolerance__)                                                          \
    {                                                                                                                                                \
        BPKVerifySnapshotOS();                                                                                                                       \
        FBSnapshotVerifyViewWithOptions(view__, identifier__, suffixes__, tolerance__);                                                              \
    }
#endif

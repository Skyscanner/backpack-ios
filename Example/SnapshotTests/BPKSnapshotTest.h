/*
 *  Copyright (c) 2017-2018, Uber Technologies, Inc.
 *  Copyright (c) 2015-2018, Facebook, Inc.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

#import <UIKit/UIKit.h>

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <FBSnapshotTestCase/FBSnapshotTestCasePlatform.h>
#import <FBSnapshotTestCase/FBSnapshotTestController.h>

#import <Backpack/DarkMode.h>

#define BPKVerifySnapshotOS()                                                                                          \
    {                                                                                                                  \
        NSString *correctDeviceName = @"iPhone 8";                                                                     \
        int correctMajorVersion = 14;                                                                                  \
        int correctMinorVersion = 0;                                                                                   \
        NSString *deviceName = [[UIDevice currentDevice] name];                                                        \
        NSOperatingSystemVersion deviceOSVersion = [[NSProcessInfo processInfo] operatingSystemVersion];               \
        BOOL validDevice = [deviceName isEqual:correctDeviceName];                                                     \
        if (deviceOSVersion.majorVersion != correctMajorVersion) {                                                     \
            validDevice = NO;                                                                                          \
        }                                                                                                              \
        if (deviceOSVersion.minorVersion != correctMinorVersion) {                                                     \
            validDevice = NO;                                                                                          \
        }                                                                                                              \
                                                                                                                       \
        NSString *correctOSVersion = [NSString stringWithFormat:@"%d.%d", correctMajorVersion, correctMinorVersion]; \
        NSString *actualOSVersion = [NSString stringWithFormat:@"%ld.%ld", deviceOSVersion.majorVersion, deviceOSVersion.minorVersion]; \
        XCTAssertTrue(validDevice, @"Snapshot tests are only valid on an %@ running iOS %@. Device was %@ running iOS %@.", correctDeviceName, correctOSVersion, deviceName, actualOSVersion); \
    }

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewLight(view__, identifier__)                                                               \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        NSString *identifier = @"light-mode";                                                                          \
        if (identifier__ != nil) {                                                                                     \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                               \
        }                                                                                                              \
                                                                                                                       \
        if (@available(iOS 13.0, *)) {                                                                                 \
            view__.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;                                             \
        }                                                                                                              \
        FBSnapshotVerifyView(view__, identifier);                                                                      \
    }
#else
#define BPKSnapshotVerifyViewLight(view__, identifier__)                                                               \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        FBSnapshotVerifyView(view__, identifier__);                                                                    \
    }
#endif

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewDark(view__, identifier__)                                                                \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        NSString *identifier = @"dark-mode";                                                                           \
        if (identifier__ != nil) {                                                                                     \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                               \
        }                                                                                                              \
                                                                                                                       \
        if (@available(iOS 13.0, *)) {                                                                                 \
            view__.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;                                              \
        }                                                                                                              \
        FBSnapshotVerifyView(view__, identifier);                                                                      \
    }
#else
#define BPKSnapshotVerifyViewDark(view__, identifier__)                                                                \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        FBSnapshotVerifyView(view__, identifier__);                                                                    \
    }
#endif

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewLightWithOptions(view__, identifier__, suffixes__, tolerance__)                           \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        NSString *identifier = @"light-mode";                                                                          \
        if (identifier__ != nil) {                                                                                     \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                               \
        }                                                                                                              \
                                                                                                                       \
        if (@available(iOS 13.0, *)) {                                                                                 \
            view__.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;                                             \
        }                                                                                                              \
        FBSnapshotVerifyViewWithOptions(view__, identifier, suffixes__, tolerance__);                                  \
    }
#else
#define BPKSnapshotVerifyViewLightWithOptions(view__, identifier__, suffixes__, tolerance__)                           \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        FBSnapshotVerifyViewWithOptions(view__, identifier__, suffixes__, tolerance__);                                \
    }
#endif

#if __BPK_DARK_MODE_SUPPORTED
#define BPKSnapshotVerifyViewDarkWithOptions(view__, identifier__, suffixes__, tolerance__)                            \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        NSString *identifier = @"dark-mode";                                                                           \
        if (identifier__ != nil) {                                                                                     \
            identifier = [NSString stringWithFormat:@"%@_%@", identifier, identifier__];                               \
        }                                                                                                              \
                                                                                                                       \
        if (@available(iOS 13.0, *)) {                                                                                 \
            view__.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;                                              \
        }                                                                                                              \
        FBSnapshotVerifyViewWithOptions(view__, identifier, suffixes__, tolerance__);                                  \
    }
#else
#define BPKSnapshotVerifyViewDarkWithOptions(view__, identifier__, suffixes__, tolerance__)                            \
    {                                                                                                                  \
        BPKVerifySnapshotOS();                                                                                         \
        FBSnapshotVerifyViewWithOptions(view__, identifier__, suffixes__, tolerance__);                                \
    }
#endif

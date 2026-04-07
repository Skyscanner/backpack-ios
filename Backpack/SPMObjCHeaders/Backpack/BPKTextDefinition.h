// BPKTextDefinition is implemented in Swift (@objcMembers).
// This header provides the ObjC interface for SPM ObjC targets that
// cannot import the Swift module directly.
#ifndef __BACKPACK_SPM_SHIM_BPKTextDefinition_H__
#define __BACKPACK_SPM_SHIM_BPKTextDefinition_H__

#import <Foundation/Foundation.h>
#import "BPKFont.h"

@interface BPKTextDefinition : NSObject
@property(readonly) BPKFontStyle fontStyle;
@property(readonly) NSRange range;
- (instancetype)initWithFontStyle:(BPKFontStyle)fontStyle range:(NSRange)range;
@end

#endif

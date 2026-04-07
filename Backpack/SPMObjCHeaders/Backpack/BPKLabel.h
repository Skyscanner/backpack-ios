// BPKLabel is implemented in Swift (@objcMembers).
// This header provides the ObjC interface for SPM ObjC targets that
// cannot import the Swift module directly.
#ifndef __BACKPACK_SPM_SHIM_BPKLabel_H__
#define __BACKPACK_SPM_SHIM_BPKLabel_H__

#import <UIKit/UIKit.h>
#import "BPKFont.h"

@interface BPKLabel : UILabel
@property(nonatomic) BPKFontStyle fontStyle;
- (instancetype)initWithFontStyle:(BPKFontStyle)style;
- (void)setFontStyle:(BPKFontStyle)fontStyle range:(NSRange)range;
@end

#endif

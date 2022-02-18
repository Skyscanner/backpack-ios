//
//  BPKButtonStyle.h
//  Pods
//
//  Created by Nicolas Frugoni on 18/02/2022.
//

typedef NS_ENUM(NSUInteger, BPKButtonStyle) {
    /**
     * Primary button style, suitable for use as the primary call to action
     */
    BPKButtonStylePrimary = 0,
    
    /**
     * Secondary button style, suitable for secondary call to actions.
     */
    BPKButtonStyleSecondary = 1,
    
    /**
     * Destructive button style, suitable for actions that are destructive.
     * Should typically be paired with a confirmation.
     */
    BPKButtonStyleDestructive = 2,
    
    /**
     * Featured button style, suitable for soem specific cases to differentiate from
     * the primary style.
     */
    BPKButtonStyleFeatured = 3,
    
    /**
     * Link button style, suitable for inline display and de-emphasized actions.
     */
    BPKButtonStyleLink = 4,
    
    /**
     * Outline button style, suitable for use on coloured backgrounds.
     */
    BPKButtonStyleOutline = 5
};

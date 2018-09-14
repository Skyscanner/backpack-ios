//
//  BPKButtonSelecorViewController.m
//  Backpack Native
//
//  Created by Laszlo Teveli on 2018. 09. 14..
//  Copyright © 2018. Skyscanner. All rights reserved.
//

#import "BPKButtonSelecorViewController.h"
#import "BPKButtonsViewController.h"

@interface BPKButtonSelecorViewController ()

@end

@implementation BPKButtonSelecorViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    BPKButtonsViewController *target = segue.destinationViewController;
    
    target.title = cell.textLabel.text;
    
    if ([segue.identifier isEqualToString:@"primary"]) {
        target.style = BPKButtonStylePrimary;
    } else if ([segue.identifier isEqualToString:@"secondary"]) {
        target.style = BPKButtonStyleSecondary;
    } else if ([segue.identifier isEqualToString:@"destructive"]) {
        target.style = BPKButtonStyleDestructive;
    } else if ([segue.identifier isEqualToString:@"featured"]) {
        target.style = BPKButtonStyleFeatured;
    }
}

@end

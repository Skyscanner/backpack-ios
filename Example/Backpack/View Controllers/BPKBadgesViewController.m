//
//  BPKBadgesViewController.m
//  Backpack_Example
//
//  Created by Hugo Tunius on 15/08/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

#import "BPKBadgesViewController.h"

#import <Backpack/Color.h>

@interface BPKBadgesViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *darkViews;

@end

@implementation BPKBadgesViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    for (UIView *v in self.darkViews) {
        v.backgroundColor = [BPKColor gray900];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  CSLAboutUsController.m
//  LiveAssistant
//
//  Created by csl on 15/12/24.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLAboutUsController.h"

@interface CSLAboutUsController ()

@end

@implementation CSLAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"about us", nil);
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

//
//  FinishRatingViewController.m
//  Movies
//
//  Created by Neha Goswami on 6/12/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import "FinishRatingViewController.h"

@interface FinishRatingViewController ()

@end

@implementation FinishRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)returnToMoreGuessingButtonPressed:(UIButton *)sender {
    [self.delegate goBack];
}

- (IBAction)seeFullStatsButtonPressed:(UIButton *)sender {
    [self.delegate seeFullStats];
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

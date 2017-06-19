//
//  RatingViewController.m
//  Movies
//
//  Created by Neha Goswami on 6/12/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import "RatingViewController.h"

@interface RatingViewController ()

@end

@implementation RatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)rateValueChanged:(UISlider *)sender {
    [_rateLabel setText:[NSString stringWithFormat:@"%0.1f", [_rateSlider value]]];
}

- (IBAction)rateButtonPressed:(UIButton *)sender {
    [self.delegate setCurrentBookRating:[_rateSlider value]];
    [self.delegate incrementJudgementCount];
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

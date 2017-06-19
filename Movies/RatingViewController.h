//
//  RatingViewController.h
//  Movies
//
//  Created by Neha Goswami on 6/12/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RatingViewController;
@protocol RatingViewControllerDelegate <NSObject>

- (void)incrementJudgementCount;
- (void)setCurrentBookRating:(float)estimate;

@end

@interface RatingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *rateSlider;
@property (strong, nonatomic) IBOutlet UILabel *rateLabel;
@property (strong, nonatomic) IBOutlet UIButton *rateButton;


@property (nonatomic, weak) id <RatingViewControllerDelegate> delegate;

@end

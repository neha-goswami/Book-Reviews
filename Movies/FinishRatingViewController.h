//
//  FinishRatingViewController.h
//  Movies
//
//  Created by Neha Goswami on 6/12/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FinishRatingViewController;
@protocol FinishRatingViewControllerDelegate <NSObject>

- (void) goBack;
- (void) seeFullStats;

@end

@interface FinishRatingViewController : UIViewController
@property (nonatomic, weak) id <FinishRatingViewControllerDelegate> delegate;
@end

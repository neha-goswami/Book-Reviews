//
//  ViewController.h
//  Movies
//
//  Created by Neha Goswami on 6/7/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bookshelf.h"
#import "RatingViewController.h"
#import "FinishRatingViewController.h"

@interface ViewController : UIViewController <RatingViewControllerDelegate, FinishRatingViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property Bookshelf *bookshelf;
@property (strong, nonatomic) IBOutlet UIImageView *coverView;
@property (strong, nonatomic) IBOutlet UIView *ratingView;
@property (strong, nonatomic) IBOutlet UIView *finishRatingView;
@property (strong, nonatomic) IBOutlet UITableView *recentlySeenBooksTableView;
@property (nonatomic, retain) UIPickerView *pickerView;
@property NSArray *judgementChoices;
@property (strong, nonatomic) UIButton *judgementNumberButton;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UIBarButtonItem *searchBarItem;
@property (strong, nonatomic) UIBarButtonItem *searchText;
@property (strong, nonatomic) UIBarButtonItem *statsBarItem;
- (void) judgementNumberButtonPressed;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@end


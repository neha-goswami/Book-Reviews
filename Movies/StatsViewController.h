//
//  StatsViewController.h
//  Movies
//
//  Created by Neha Goswami on 6/13/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface StatsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property NSMutableArray *seenBooks;
@property (strong, nonatomic) IBOutlet UICollectionView *seenCollectionView;

@property (strong, nonatomic) IBOutlet UIImageView *selectedBookPreview;
@property (strong, nonatomic) IBOutlet UILabel *selectedBookTitle;
@property (strong, nonatomic) IBOutlet UILabel *selectedBookAuthor;
@property (strong, nonatomic) IBOutlet UILabel *selectedBookDescription;
@property (strong, nonatomic) IBOutlet UILabel *selectedBookRatings;


@end

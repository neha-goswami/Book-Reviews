//
//  StatsViewController.m
//  Movies
//
//  Created by Neha Goswami on 6/13/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import "StatsViewController.h"
#import "BookViewCell.h"
#import "Book.h"

@interface StatsViewController ()

@property BookViewCell *previouslySelectedCell;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _seenCollectionView.delegate = self;
    _seenCollectionView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setSelectedBook:[_seenBooks objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions


#pragma mark - datasource and delegate required methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_seenBooks count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Book *book = [_seenBooks objectAtIndex:indexPath.row];
    NSURL *thumbnailURL = [NSURL URLWithString:[book bookThumbnail]];
    cell.book = book;
    cell.seenBookView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:thumbnailURL]];
    cell.seenTitleLabel.text = [book bookTitle];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BookViewCell *cell = (BookViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [self setSelectedBook:[cell book]];
    [_previouslySelectedCell.layer setBorderColor:[UIColor clearColor].CGColor];
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor blueColor].CGColor];
    _previouslySelectedCell = cell;
    
}

- (void)setSelectedBook:(Book *)book {
    [self.selectedBookPreview setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[book bookThumbnail]]]]];
    [self.selectedBookTitle setText:[book bookTitle]];
    [self.selectedBookAuthor setText:[book bookAuthor]];
    [self.selectedBookDescription setText:[book bookDescription]];
    [self.selectedBookRatings setText:[NSString stringWithFormat:@"real rating: %0.1f // your guess: %0.1f", [[book bookRating] floatValue], [book guessRating]]];
}


@end

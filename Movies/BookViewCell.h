//
//  BookViewCell.h
//  Movies
//
//  Created by Neha Goswami on 6/13/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Book;

@interface BookViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *seenBookView;
@property (strong, nonatomic) IBOutlet UILabel *seenTitleLabel;
@property Book *book;

@end

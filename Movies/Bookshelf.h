//
//  Bookshelf.h
//  Movies
//
//  Created by Neha Goswami on 6/8/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface Bookshelf : NSObject
@property NSMutableArray *unseenBooks;
@property NSMutableArray *seenBooks;
@property NSMutableArray *recentlySeenBooks;
- (void) addNewUnseenBookWithSpecifications: (NSString *)bookID
                                      title: (NSString *)bookTitle
                                     rating: (NSNumber *)bookRating
                             smallThumbnail: (NSString *)smallThumbnail
                                  thumbnail: (NSString *)thumbnail
                                     author: (NSString *)author
                                description: (NSString *)description;

- (NSString *) getNextUnseenImage;

- (void) setBookEstimate:(float)estimate;

- (float) getEstimateOffset;

- (void) resetRecentlySeenBooks;

- (void) recalibrateBookShelf;

@end

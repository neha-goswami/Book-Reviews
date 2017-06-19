//
//  Book.m
//  Movies
//
//  Created by Neha Goswami on 6/8/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import "Book.h"

@implementation Book

- (id) initWithSpecifications:(NSString *)bookID
                        title:(NSString *)bookTitle
                       rating:(NSNumber *)bookRating
               smallThumbnail:(NSString *)smallThumbnail
                    thumbnail:(NSString *)thumbnail
                       author:(NSString *)author
                  description:(NSString *)description{
    self = [super init];
    
    if (self) {
        [self setBookID:bookID];
        [self setBookTitle:bookTitle];
        [self setBookRating:bookRating];
        [self setBookSmallThumbnail:smallThumbnail];
        [self setBookThumbnail:thumbnail];
        [self setBookAuthor:author];
        [self setBookDescription:description];
    }
    
    return self;
}

@end

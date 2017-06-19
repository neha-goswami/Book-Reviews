//
//  Bookshelf.m
//  Movies
//
//  Created by Neha Goswami on 6/8/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import "Bookshelf.h"
#import "Book.h"

@interface Bookshelf()

@property Book *currentBook;

@end

@implementation Bookshelf

- (id) init {
    self = [super init];
    _unseenBooks = [[NSMutableArray alloc] init];
    _seenBooks = [[NSMutableArray alloc] init];
    _recentlySeenBooks = [[NSMutableArray alloc] init];
    return self;
}

- (void) addNewUnseenBookWithSpecifications:(NSString *)bookID
                                      title:(NSString *)bookTitle
                                     rating:(NSNumber *)bookRating
                             smallThumbnail:(NSString *)smallThumbnail
                                  thumbnail:(NSString *)thumbnail
                                     author:(NSString *)author
                                description:(NSString *)description{
    Book *book = [[Book alloc] initWithSpecifications:bookID
                                                title:bookTitle
                                               rating:bookRating
                                       smallThumbnail:smallThumbnail
                                            thumbnail:thumbnail
                                               author:author
                                          description:description];
    [_unseenBooks insertObject:book atIndex:0];
}

-(void) recalibrateBookShelf{
    _currentBook = [_unseenBooks objectAtIndex:0];
}

- (NSString *) getNextUnseenImage {
    if ([_unseenBooks count]) {
        _currentBook = [_unseenBooks objectAtIndex:0];
        NSString *thumbnail = [_currentBook bookThumbnail];
        if (thumbnail) {
            return thumbnail;
        } else {
            return [_currentBook bookSmallThumbnail];
        }
    } else {
        return nil;
    }
}

- (void) setBookEstimate:(float) estimate {
    [_currentBook setGuessRating:estimate];
    [_recentlySeenBooks addObject:_currentBook];
    [_unseenBooks removeObjectAtIndex:0];
    [_seenBooks addObject:_currentBook];
}

- (float) getEstimateOffset{
    return [_currentBook.bookRating floatValue] - _currentBook.guessRating;
}

- (void) resetRecentlySeenBooks {
    _recentlySeenBooks = nil;
    _recentlySeenBooks = [[NSMutableArray alloc] init];
}

@end

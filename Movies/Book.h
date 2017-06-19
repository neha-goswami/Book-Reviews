//
//  Book.h
//  Movies
//
//  Created by Neha Goswami on 6/8/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Book : NSObject

@property NSString *bookID;
@property NSString *bookTitle;
@property NSNumber *bookRating;
@property NSString *bookSmallThumbnail;
@property NSString *bookThumbnail;
@property float guessRating;
@property NSString *bookAuthor;
@property NSString *bookDescription;



- (id) initWithSpecifications: (NSString *)bookID
                        title: (NSString *)bookTitle
                       rating: (NSNumber *)bookRating
               smallThumbnail: (NSString *)smallThumbnail
                    thumbnail: (NSString *)thumbnail
                       author: (NSString *)author
                  description: (NSString *)description;
@end


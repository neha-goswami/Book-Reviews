//
//  ViewController.m
//  Movies
//
//  Created by Neha Goswami on 6/7/17.
//  Copyright © 2017 Neha Goswami. All rights reserved.
//


#import "ViewController.h"
#import "Book.h"
#import "StatsViewController.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kGoogleBooksURL [NSURL URLWithString: @"https://www.googleapis.com/books/v1/volumes?q=+maxResults=10&key=AIzaSyAzxaAwSww41gw2YLLnkgOuED1zKrfS8DM"] //2

@interface ViewController ()

{
    NSMutableArray *recentlySeenBooks;
    NSString *categoryText;
    UIPickerView *pickerView;
}

@property int judgementCount;
@property int judgementCountChoice;
@end

@implementation ViewController

@synthesize pickerView;
@synthesize judgementChoices;

- (IBAction)unwindToRatingScreen:(UIStoryboardSegue *)unwindSegue{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ratingSegue"] || [segue.identifier isEqualToString:@"finishRatingSegue"]) {
        RatingViewController *ratingViewController = segue.destinationViewController;
        ratingViewController.delegate = self;
        [ratingViewController.view setBackgroundColor:[UIColor clearColor]];
        
    } else if ([segue.identifier isEqualToString:@"statSegue"]) {
        StatsViewController *statsViewController = segue.destinationViewController;
        [statsViewController setSeenBooks:[_bookshelf seenBooks]];
    }
}

- (void)incrementJudgementCount{
    _judgementCount++;
    NSLog(@"%d", _judgementCount);

    if (_judgementCount == _judgementCountChoice) {
        _judgementCount = -1;
        [_ratingView setHidden:YES];
        [_finishRatingView setHidden:NO];
        [_coverView setHidden:YES];
        
        //show the table view now...
        [self setUpRecentlySeenBooksArray];
        [_recentlySeenBooksTableView reloadData];
        [_recentlySeenBooksTableView setHidden:NO];
        categoryText = _categoryLabel.text;
        [_categoryLabel setText:@"See how you did!"];
        [_scoreLabel setHidden:NO];

        return;
    }
    
    if (_judgementCount == 0) {
        [_coverView setHidden:NO];
        [_ratingView setHidden:NO];
        [_finishRatingView setHidden:YES];
        [_recentlySeenBooksTableView setHidden: YES];
        [_bookshelf resetRecentlySeenBooks];
        [_categoryLabel setHidden:NO];
        [_categoryLabel setText:categoryText];
        [_scoreLabel setHidden:YES];

        
    }

    [self displayNextCover];
}

//returns how far off the user was.  ie, "you guessed +/-1.3 points above the actual rating"
- (void)setCurrentBookRating:(float)estimate{
    [_bookshelf setBookEstimate:estimate];
}

#pragma mark - Rating/FinishRating VC required methods

- (void)goBack{
    [self incrementJudgementCount];
}

- (void)seeFullStats{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    StatsViewController *vc = (StatsViewController *) [storyboard instantiateViewControllerWithIdentifier:@"statsVC"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [navController setNavigationBarHidden:NO];
    [vc setSeenBooks:[_bookshelf seenBooks]];
    [self presentViewController:navController animated:NO completion:nil];
    
}

- (void)setUpRecentlySeenBooksArray {
    recentlySeenBooks = [_bookshelf recentlySeenBooks]; // i don't want separate arrays for titles so books it is
    NSLog(@"%@", [recentlySeenBooks description]);
}

#pragma mark - UITableView DataSource required methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [recentlySeenBooks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Book *book = [recentlySeenBooks objectAtIndex:(int)indexPath.row];
    
    //format: expected actual
    NSString *ratings = [NSString stringWithFormat:@"%0.1f // %0.1f", [book guessRating], [[book bookRating] floatValue]];
    
    cell.textLabel.text = [book bookTitle];
    cell.detailTextLabel.text = ratings;
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[book bookSmallThumbnail]]]];
    return cell;
}

#pragma mark - UIPickerView required methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [judgementChoices count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [judgementChoices objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _judgementCountChoice = (int) row + 2;

    [_coverView setAlpha:1];
}

#pragma mark - search related

- (void)searchButtonPressed{
    [_searchBar setText:nil];
    [_searchBar setShowsCancelButton:YES];
    [self.navigationItem setLeftBarButtonItem:_searchBarItem];
    [self.navigationItem setRightBarButtonItem:nil];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.navigationItem setLeftBarButtonItem:_searchText];
    [self.navigationItem setRightBarButtonItem:_statsBarItem];
    if (searchBar.text != nil || ![searchBar.text isEqualToString:@""]) {
        [self searchForNewCategory:searchBar.text];
        [self.categoryLabel setText:[NSString stringWithFormat:@"Category: %@", searchBar.text.lowercaseString]];
        [self displayNextCover];
    }

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setText:nil];
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.view endEditing:YES];
    [self.navigationItem setLeftBarButtonItem:_searchText];
    [self.navigationItem setRightBarButtonItem:_statsBarItem];
}

- (void)searchForNewCategory:(NSString *)category{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
    NSURL *url = [self createURLfromStringForRequest:category];
    [request setURL:url];

    NSHTTPURLResponse *responseCode = nil;
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       [self fetchedData:data];
                                                   }];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
    }
    [dataTask resume];
}


#pragma mark - setup

- (NSURL *)createURLfromStringForRequest:(NSString *)category{
    NSString *url;
    if (category == nil || [category isEqualToString:@""]) {
        url = @"https://www.googleapis.com/books/v1/volumes?q=the+subject:fiction&maxResults=7&key=AIzaSyAzxaAwSww41gw2YLLnkgOuED1zKrfS8DM";
        NSLog(@"category is being run after i hit ficiton");
    } else {
        url = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=the+subject:%@&maxResults=6&key=AIzaSyAzxaAwSww41gw2YLLnkgOuED1zKrfS8DM", category];
        NSLog(@"%@ was chosen",category);
    }
    return [NSURL URLWithString:url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_async(kBgQueue, ^{NSData *data = [NSData dataWithContentsOfURL:[self createURLfromStringForRequest:nil]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
    recentlySeenBooks = [[NSMutableArray alloc] init];
    [_recentlySeenBooksTableView setHidden: YES];
    [_recentlySeenBooksTableView setDelegate:self];
    [_recentlySeenBooksTableView setDataSource:self];
    [_finishRatingView setHidden:YES];

    _bookshelf = [[Bookshelf alloc] init];
    _judgementCountChoice = 5;
    
    
    
    _searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    self.navigationItem.leftBarButtonItem = _searchBarItem;
    [_searchBar setShowsCancelButton:YES];
    [self.navigationItem.leftBarButtonItem setAccessibilityElementsHidden:YES];
    
    _searchText = [[UIBarButtonItem alloc] initWithTitle:@"Search"
                                                   style:UIBarButtonItemStylePlain
                                                  target:self
                                                action:@selector(searchButtonPressed)];
    self.navigationItem.leftBarButtonItem = _searchText;
    _statsBarItem = self.navigationItem.rightBarButtonItem;
    [_scoreLabel setHidden:YES];
    
//    [self createJudgementChoiceCountButton];
//    [self createJudgementNumberPicker];
//    [self.bookPickerLabel setHidden:YES];

}

- (void) createJudgementNumberPicker{
    judgementChoices = @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
    float pickerWidth = _coverView.bounds.size.width;
    float xPicker = _coverView.frame.origin.x;
    float yPicker = _coverView.frame.origin.y + 10.0;
    
    pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setFrame:CGRectMake(xPicker, yPicker, pickerWidth, 200.0f)];
    pickerView.showsSelectionIndicator = YES;
    [pickerView selectRow:2 inComponent:0 animated:YES];
    [self.view addSubview:pickerView];
    [pickerView setHidden:YES];
}

- (void)createJudgementChoiceCountButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(judgementNumberButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"3" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.88 * self.view.bounds.size.width, self.view.bounds.size.height * 0.13, 40.0, 40.0);
    button.clipsToBounds = YES;
    
    button.layer.cornerRadius = 20.0;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 2.0f;
    [self.view addSubview:button];
    
    _judgementNumberButton = button;
    
    [_judgementNumberButton setHidden:NO];
}

- (void)judgementNumberButtonPressed{
    [_coverView setAlpha:0.2];
    [pickerView setHidden:NO];
    [_ratingView setUserInteractionEnabled:NO];
    [_ratingView setAlpha:0.2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchedData:(NSData *)responseData {
    NSError *error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSArray *books = [json objectForKey:@"items"];
    
    
    for (int i = 0; i < [books count]; i++) {
        NSDictionary *book = [books objectAtIndex:i];
        NSString *bookID = [book objectForKey:@"id"];
        
        NSDictionary *bookVolumeInfo = [book objectForKey:@"volumeInfo"];
        NSString *bookTitle = [bookVolumeInfo objectForKey:@"title"];
        NSNumber *bookRating = [bookVolumeInfo objectForKey:@"averageRating"];
        NSString *bookDescription = [bookVolumeInfo objectForKey:@"description"];
        
        NSArray *bookAuthors = [bookVolumeInfo objectForKey:@"authors"];
        NSString *author = [bookAuthors objectAtIndex:0];
        
        NSDictionary *bookImageLinks = [bookVolumeInfo objectForKey:@"imageLinks"];
        NSString *bookSmallThumbnail = [bookImageLinks objectForKey:@"smallThumbnail"];
        NSString *bookThumbnail = [bookImageLinks objectForKey:@"thumbnail"];
        if (bookThumbnail != nil && bookDescription != nil && [bookTitle length] < 35) {
            [_bookshelf addNewUnseenBookWithSpecifications:bookID
                                                 title:bookTitle
                                                rating:bookRating
                                        smallThumbnail:bookSmallThumbnail
                                             thumbnail:bookThumbnail
                                                author:author
                                           description:bookDescription];
        }
    }
    [_bookshelf recalibrateBookShelf];
    [self displayNextCover];
}

- (void) displayNextCover {
    [_coverView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_bookshelf getNextUnseenImage]]]]];
}

@end

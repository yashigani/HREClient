//
//  StationSearchViewController.h
//  RecommendArbeit
//
//  Created by taiki on 2/5/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StationSearchViewController;

@protocol StationSearchViewControllerDelegate <NSObject>
- (void)stationSearchViewController:(StationSearchViewController *)stationSearchViewController didSelectStation:(NSDictionary *)station;
@end

@interface StationSearchViewController : UITableViewController
@property (weak, nonatomic) IBOutlet id<StationSearchViewControllerDelegate> delegate;

@end

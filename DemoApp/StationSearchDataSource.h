//
//  StationSearchDataSource.h
//  RecommendArbeit
//
//  Created by taiki on 2/5/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationSearchDataSource : NSObject <UITableViewDataSource>
@property (strong, nonatomic, readonly) NSArray *stations;

- (void)refresh:(NSString *)station;
- (void)refresh:(NSString *)station completionHandler:(void (^)(void))completion;

@end

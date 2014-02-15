//
//  StationSearchDataSource.m
//  RecommendArbeit
//
//  Created by taiki on 2/5/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import "StationSearchDataSource.h"

#import "HREClient.h"

@interface StationSearchDataSource ()
@property (strong, nonatomic) HREClient *client;
@property (strong, nonatomic, readwrite) NSArray *stations;
@end

@implementation StationSearchDataSource

- (void)nsd_init
{
    _client = HREClient.new;
    _stations = @[];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self nsd_init];
    }
    return self;
}

- (void)refresh:(NSString *)station
{
    [self refresh:station completionHandler:nil];
}

- (void)refresh:(NSString *)station completionHandler:(void (^)(void))completion
{
    if (!station) {
        return;
    }

    __weak __typeof(self) wself = self;
    [_client cancelAllRequest];
    [_client getStations:station
       completionHandler:^(NSArray *results, NSError *e) {
           if (!e) {
               NSMutableArray *stations = NSMutableArray.array;
               [results enumerateObjectsUsingBlock:^(NSDictionary *station, NSUInteger idx, BOOL *stop) {
                   [stations addObject:station];
               }];
               NSUInteger count = wself.stations.count;
               NSMutableArray *proxy =
                   [wself mutableArrayValueForKey:@"stations"];
               [proxy replaceObjectsInRange:NSMakeRange(0, count)
                       withObjectsFromArray:stations];
           }
           if (completion) { completion(); }
       }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    NSDictionary *station = _stations[indexPath.row];
    cell.textLabel.text = [HREClient stationName:station];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stations.count;
}

@end

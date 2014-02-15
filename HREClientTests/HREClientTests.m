//
//  HREClientTests.m
//  RecommendArbeit
//
//  Created by taiki on 2/14/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TRVSMonitor.h"

#import "HREClient.h"

@interface HREClientTests : XCTestCase
@property (strong, nonatomic) HREClient *client;
@end

@implementation HREClientTests

- (void)setUp
{
    [super setUp];
    _client = [HREClient new];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testHREClient
{
    TRVSMonitor *monitor = TRVSMonitor.monitor;
    // HREClient finds stations.
    [_client getStations:@"新宿"
       completionHandler:^(NSArray *res, NSError *e) {
           XCTAssertNil(e, @":(");
           XCTAssertNotNil(res, @":(");
           [monitor signal];
       }];
    [monitor wait];

    // HREClient finds no stations.
    [_client getStations:@"杜王町"
       completionHandler:^(NSArray *res, NSError *e) {
           XCTAssertNotNil(e, @":(");
           XCTAssertNotNil(e.userInfo[@"error"], @":(");
           XCTAssertNil(res, @":(");
           [monitor signal];
       }];
    [monitor wait];
}

@end

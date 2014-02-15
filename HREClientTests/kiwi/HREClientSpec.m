//
//  HREClientSpec.m
//  RecommendArbeit
//
//  Created by taiki on 2/4/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Kiwi.h"
#import "TRVSMonitor.h"

#import "HREClient.h"

SPEC_BEGIN(HREClientSpec)

describe(@"HREClient", ^{
    __block HREClient *client = nil;

    beforeEach(^{
        client = [HREClient new];
    });

    it(@"should found stations", ^{
        TRVSMonitor *monitor = TRVSMonitor.monitor;
        [client getStations:@"新宿"
          completionHandler:^(NSArray *res, NSError *e) {
              [[e should] beNil];
              [[res should] beNonNil];
              [monitor signal];
          }];
        [monitor wait];
    });

    it(@"should not found stations", ^{
        TRVSMonitor *monitor = TRVSMonitor.monitor;
        [client getStations:@"杜王町"
            completionHandler:^(NSArray *res, NSError *e) {
              [[e should] beNonNil];
              [[e.userInfo[@"error"] should] beNonNil];
              [[res should] beNil];
              [monitor signal];
          }];
        [monitor wait];
    });
});

SPEC_END

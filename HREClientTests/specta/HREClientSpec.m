//
//  HREClientSpecta.m
//  RecommendArbeit
//
//  Created by taiki on 2/14/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#define EXP_SHORTHAND

#import "Specta.h"
#import "Expecta.h"

#import "HREClient.h"

SpecBegin(HREClientSpecta)

describe(@"HREClient", ^{
    __block HREClient *client = nil;

    beforeEach(^{
        client = [HREClient new];
    });

    it(@"should found stations", ^AsyncBlock {
        [client getStations:@"新宿"
          completionHandler:^(NSArray *res, NSError *e) {
              expect(e).to.beNil();
              expect(res).notTo.beNil();
              done();
          }];
    });

    it(@"should not found stations", ^AsyncBlock {
        [client getStations:@"杜王町"
          completionHandler:^(NSArray *res, NSError *e) {
              expect(e).notTo.beNil();
              expect(e.userInfo[@"error"]).notTo.beNil();
              expect(res).to.beNil();
              done();
          }];
    });
});

SpecEnd

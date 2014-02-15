//
//  HREClient.h
//  RecommendArbeit
//
//  Created by taiki on 2/4/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const HREErrorDomain;

typedef NS_ENUM(NSUInteger, HREErrorCode) {
    HRENotFound,
};

@interface HREClient : NSObject

+ (NSString *)stationName:(NSDictionary *)station;

- (NSURLSessionDataTask *)getStations:(NSString *)station completionHandler:(void (^)(NSArray *response, NSError *error))completionHandler;
- (void)cancelAllRequest;

@end

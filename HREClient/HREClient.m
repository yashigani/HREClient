
//
//  HREClient.m
//  RecommendArbeit
//
//  Created by taiki on 2/4/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import "HREClient.h"

#import "AFNetworking.h"

NSString * const HREClientBaseURL = @"http://express.heartrails.com/";
NSString * const HREErrorDomain = @"HREErrorDomain";

@interface HREClient ()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation HREClient

+ (NSString *)stationName:(NSDictionary *)station
{
    NSString *name = station[@"name"];
    if (station[@"line"]) {
        name = [name stringByAppendingFormat:@" (%@)", station[@"line"]];
    }
    return name;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *baseURL = [NSURL URLWithString:HREClientBaseURL];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (NSURLSessionDataTask *)getStations:(NSString *)station completionHandler:(void (^)(NSArray *response, NSError *error))completionHandler
{
    if (!station) {
        // TODO: raise error
        return nil;
    }

    NSDictionary *params = @{
        @"method": @"getStations", @"name": station,
    };
    NSURLSessionDataTask *task =
        [_manager GET:@"/api/json"
           parameters:params
              success:^(NSURLSessionDataTask *task, NSDictionary *response) {
                  NSArray *results = response[@"response"][@"station"];
                  NSError *error = nil;
                  if (!results) {
                      error = [NSError errorWithDomain:HREErrorDomain code:HRENotFound userInfo:response[@"response"]];
                  }
                  completionHandler(results, error);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  completionHandler(nil, error);
              }];
    return task;
}

- (void)cancelAllRequest
{
    for (NSURLSessionDataTask *task in _manager.dataTasks) {
        [task cancel];
    }
}

@end

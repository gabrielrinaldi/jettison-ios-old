//
//  JTSDrop.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import "JTSAzureClient.h"
#import "JTSDrop.h"

@import MapKit;

#pragma mark JTSDrop

@implementation JTSDrop

#pragma mark - Class

+ (NSString *)tableName {
    return @"drops";
}

#pragma mark - Initialization

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _rid = dictionary[@"id"];
        _message = dictionary[@"message"];
        _location = [[CLLocation alloc] initWithLatitude:[dictionary[@"latitude"] floatValue] longitude:[dictionary[@"longitude"] floatValue]];
    }
    
    return self;
}

+ (void)dropsNearLocation:(CLLocation *)location completion:(void (^)(NSArray *items, NSError *error))completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"latitude"] = [NSNumber numberWithFloat:location.coordinate.latitude];
    parameters[@"longitude"] = [NSNumber numberWithFloat:location.coordinate.longitude];
    
    [[JTSAzureClient sharedClient] invokeAPI:@"discover" body:nil HTTPMethod:@"GET" parameters:parameters headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
        if (!error && result && completion) {
            NSMutableArray *parsedItems = [NSMutableArray array];
            for (NSDictionary *dictionary in result) {
                JTSModel *model = [[self alloc] initWithDictionary:dictionary];
                [parsedItems addObject:model];
            }
            
            completion(parsedItems, nil);
        } else if (completion) {
            completion(nil, error);
        }
    }];
}

#pragma mark - Dictionary

- (NSDictionary *)dictionary {
    NSDictionary *drop = @{
                           @"message" : [self message],
                           @"latitude" : [NSNumber numberWithFloat:self.location.coordinate.latitude],
                           @"longitude" : [NSNumber numberWithFloat:self.location.coordinate.longitude]
                           };
    return drop;
}

@end

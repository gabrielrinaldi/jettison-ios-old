//
//  JTSDrop.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import "JTSModel.h"

@class CLLocation;

#pragma mark JTSDrop

@interface JTSDrop : JTSModel

@property (strong, nonatomic, readonly) NSString *rid;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) CLLocation *location;

+ (void)dropsNearLocation:(CLLocation *)location completion:(void (^)(NSArray *items, NSError *error))completion;

@end

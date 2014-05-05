//
//  JTSModel.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import "JTSAzureClient.h"
#import "JTSModel.h"

#pragma mark JTSModel (Private)

@interface JTSModel ()

@property (strong, nonatomic) MSTable *table;

@end

#pragma mark - JTSModel

@implementation JTSModel

#pragma mark - Getters/Setters

@synthesize table;

#pragma mark - Class

+ (NSString *)tableName {
    return @"models";
}

#pragma mark - Helpers

+ (MSTable *)table {
    return [[JTSAzureClient sharedClient] tableWithName:[self tableName]];
}

+ (void)readWithPredicate:(NSPredicate *)predicate completion:(void (^)(NSArray *items, NSError *error))completion {
    [[self table] readWithPredicate:predicate completion:^(NSArray *items, NSInteger totalCount, NSError *error) {
        if (!error && items && completion) {
            NSMutableArray *parsedItems = [NSMutableArray array];
            for (NSDictionary *dictionary in items) {
                JTSModel *model = [[self alloc] initWithDictionary:dictionary];
                [parsedItems addObject:model];
            }
            
            completion(parsedItems, nil);
        } else if (completion) {
            completion(nil, error);
        }
    }];
}

#pragma mark - Initialization

- (id)initWithDictionary:(NSDictionary *)dictionary {
    return [self init];
}

- (id)init {
    self = [super init];
    if (self) {
        [self setTable:[[self class] table]];
    }
    
    return self;
}

#pragma mark - API

- (void)saveWithCompletion:(void (^)(NSDictionary *, NSError *))completion {
    [[self table] insert:[self dictionary] completion:completion];
}

- (void)updateWithCompletion:(void (^)(NSDictionary *item, NSError *error))completion {
    [[self table] update:[self dictionary] completion:completion];
};

#pragma mark - Dictionary

- (NSDictionary *)dictionary {
    return @{ };
}

@end

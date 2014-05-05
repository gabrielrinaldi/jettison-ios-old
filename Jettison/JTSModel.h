//
//  JTSModel.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

@class MSTable;

#pragma mark JTSModel

@interface JTSModel : NSObject

+ (NSString *)tableName;
+ (MSTable *)table;
+ (void)readWithPredicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)saveWithCompletion:(void (^)(NSDictionary *result, NSError *error))completion;
- (void)updateWithCompletion:(void (^)(NSDictionary *item, NSError *error))completion;
- (NSDictionary *)dictionary;

@end

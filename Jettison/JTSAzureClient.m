//
//  JTSAzureClient.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import <UICKeyChainStore/UICKeyChainStore.h>
#import "JTSAzureClient.h"

static NSString * const kGRAAPIBaseURLString = AZURE_BASE_URL;

#pragma mark JTSAzureClient

@implementation JTSAzureClient

#pragma mark - Shared client

+ (instancetype)sharedClient {
    static JTSAzureClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithApplicationURL:[NSURL URLWithString:kGRAAPIBaseURLString] applicationKey:AZURE_APPLICATION_KEY];
    });
    
    return _sharedClient;
}

#pragma mark - Initializer

- (id)initWithApplicationURL:(NSURL *)url applicationKey:(NSString *)key {
    self = [super initWithApplicationURL:url applicationKey:key];
    if (self) {
        [self restoreUser];
    }
    
    return self;
}

#pragma mark - Authentication

- (void)loginUserWithToken:(NSString *)token completion:(void (^)(NSError *))completion {
    [self loginWithProvider:@"facebook" token:@{ @"access_token": token } completion:^(MSUser *user, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            
            if (completion) {
                completion(error);
            }
        } else {
            [UICKeyChainStore setString:[user userId] forKey:@"userID"];
            [UICKeyChainStore setString:[user mobileServiceAuthenticationToken] forKey:@"facebookID"];
            
            if (completion) {
                completion(nil);
            }
        }
    }];
}

- (BOOL)restoreUser {
    if ([self currentUser]) {
        return YES;
    }
    
    NSString *userId = [UICKeyChainStore stringForKey:@"userID"];
    NSString *facebookId = [UICKeyChainStore stringForKey:@"facebookID"];
    
    if (userId && facebookId) {
        MSUser *user = [[MSUser alloc] initWithUserId:userId];
        [user setMobileServiceAuthenticationToken:facebookId];
        [self setCurrentUser:user];
        
        return YES;
    }
    
    return NO;
}

- (void)logoutUser {
    [UICKeyChainStore removeItemForKey:@"userID"];
    [UICKeyChainStore removeItemForKey:@"facebookID"];
    
    [self logout];
}

@end

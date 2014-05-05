//
//  JTSAzureClient.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

#pragma mark JTSAzureClient

@interface JTSAzureClient : MSClient

+ (instancetype)sharedClient;
- (void)loginUserWithToken:(NSString *)token completion:(void (^)(NSError *error))completion;
- (BOOL)restoreUser;
- (void)logoutUser;

@end

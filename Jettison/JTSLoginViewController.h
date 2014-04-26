//
//  JTSLoginViewController.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

@class FBLoginView;
@protocol JTSLoginViewControllerDelegate;

#pragma mark JTSLoginViewController

@interface JTSLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) id <JTSLoginViewControllerDelegate> delegate;

@end

#pragma mark - JTSLoginViewControllerDelegate

@protocol JTSLoginViewControllerDelegate <NSObject>

- (void)loginViewControllerDidLogin;

@end

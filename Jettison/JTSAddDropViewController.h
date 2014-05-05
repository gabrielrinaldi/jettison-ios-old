//
//  JTSAddDropViewController.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import <BZGFormViewController/BZGFormViewController.h>

@protocol JTSAddDropViewControllerDelegate;

#pragma mark JTSAddDropViewController

@interface JTSAddDropViewController : BZGFormViewController

@property (weak, nonatomic) id <JTSAddDropViewControllerDelegate> delegate;

@end

#pragma mark - JTSAddDropViewControllerDelegate

@protocol JTSAddDropViewControllerDelegate <NSObject>

- (void)addDropViewControllerDidCancel;
- (void)addDropViewControllerDidAdd;

@end

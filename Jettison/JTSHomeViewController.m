//
//  JTSHomeViewController.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import <FormatterKit/TTTLocationFormatter.h>
#import <MZFormSheetController/MZFormSheetController.h>
#import <VPPLocation/VPPLocationController.h>
#import "JTSDrop.h"
#import "JTSAddDropViewController.h"
#import "JTSDropDetailViewController.h"
#import "JTSHomeViewController.h"

@import MapKit;

#pragma mark JTSHomeViewController (Private)

@interface JTSHomeViewController () <JTSAddDropViewControllerDelegate, VPPLocationControllerLocationDelegate> @end

#pragma mark - JTSHomeViewController

@implementation JTSHomeViewController

#pragma mark - Button action

- (void)addDrop {
    JTSAddDropViewController *addDropViewController = [[JTSAddDropViewController alloc] init];
    [addDropViewController setDelegate:self];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addDropViewController];
    
    [[MZFormSheetController sharedBackgroundWindow] setBackgroundBlurEffect:YES];
    [[MZFormSheetController sharedBackgroundWindow] setBlurRadius:5.0];
    [[MZFormSheetController sharedBackgroundWindow] setBackgroundColor:[UIColor clearColor]];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:navigationController];
    [formSheet setShouldDismissOnBackgroundViewTap:NO];
    [formSheet setTransitionStyle:MZFormSheetTransitionStyleSlideFromBottom];
    [formSheet setCornerRadius:5];
    [formSheet setPortraitTopInset:40];
    [formSheet setLandscapeTopInset:20];
    [formSheet setPresentedFormSheetSize:CGSizeMake(280, 320)];
    [formSheet setMovementWhenKeyboardAppears:MZFormSheetWhenKeyboardAppearsDoNothing];
    [formSheet presentAnimated:YES completionHandler:nil];
}

#pragma mark - Refresh data

- (void)refresh {
    [JTSDrop dropsNearLocation:[[VPPLocationController sharedInstance] currentLocation] completion:^(NSArray *items, NSError *error) {
        if (!error && [items count] > 0) {
            JTSDrop *drop = items[0];
            
            float distance = [[[VPPLocationController sharedInstance] currentLocation] distanceFromLocation:[drop location]];
            TTTLocationFormatter *locationFormatter = [[TTTLocationFormatter alloc] init];
            [[self distanceLabel] setText:[locationFormatter stringFromDistance:distance]];
            
            if (distance <= 10) {
                JTSDropDetailViewController *dropDetailViewController = [[JTSDropDetailViewController alloc] initWithNibName:@"JTSDropDetailViewController" bundle:nil];
                [dropDetailViewController setDrop:drop];
                
                [[MZFormSheetController sharedBackgroundWindow] setBackgroundBlurEffect:YES];
                [[MZFormSheetController sharedBackgroundWindow] setBlurRadius:5.0];
                [[MZFormSheetController sharedBackgroundWindow] setBackgroundColor:[UIColor clearColor]];
                
                MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:dropDetailViewController];
                [formSheet setShouldDismissOnBackgroundViewTap:YES];
                [formSheet setTransitionStyle:MZFormSheetTransitionStyleBounce];
                [formSheet setCornerRadius:5];
                [formSheet setPortraitTopInset:40];
                [formSheet setLandscapeTopInset:20];
                [formSheet setPresentedFormSheetSize:CGSizeMake(280, 200)];
                [formSheet setMovementWhenKeyboardAppears:MZFormSheetWhenKeyboardAppearsDoNothing];
                [formSheet presentAnimated:YES completionHandler:nil];
            }
        } else {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - Add drop view controller delegate

- (void)addDropViewControllerDidAdd {
    // TODO: Reload maps
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

- (void)addDropViewControllerDidCancel {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

#pragma mark - Location delegate

- (void)locationUpdate:(CLLocation *)location {
    [self refresh];
    
    if ([[self dropsMapView] userTrackingMode] != MKUserTrackingModeFollow) {
        [[self dropsMapView] setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
}

- (void)locationDenied {
    // TODO: Show error
}

- (void)locationError:(NSError *)error {
    // TODO: Show error
    NSLog(@"Error: %@", error);
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"AppName", nil)];
    
    UIBarButtonItem *settingsBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Settings"] style:UIBarButtonItemStylePlain target:self action:nil];
    [[self navigationItem] setLeftBarButtonItem:settingsBarButtonItem];
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add"] style:UIBarButtonItemStylePlain target:self action:@selector(addDrop)];
    [[self navigationItem] setRightBarButtonItem:addBarButtonItem];
    
    [[VPPLocationController sharedInstance] setShouldRejectRepeatedLocations:YES];
    [[VPPLocationController sharedInstance] setDesiredLocationAccuracy:50];
    [[VPPLocationController sharedInstance] setStrictMode:YES];
    [[VPPLocationController sharedInstance] addLocationDelegate:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refresh];
    });
}

@end

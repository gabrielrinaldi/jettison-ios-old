//
//  JTSDropDetailViewController.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import "JTSDrop.h"
#import "JTSDropDetailViewController.h"

#pragma mark JTSDropDetailViewController (Private)

@interface JTSDropDetailViewController () @end

#pragma mark - JTSDropDetailViewController

@implementation JTSDropDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self messageLabel] setText:[[self drop] message]];
}

@end

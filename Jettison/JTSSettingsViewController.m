//
//  JTSSettingsViewController.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 5/10/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import "JTSSettingsViewController.h"

#pragma mark JTSSettingsViewController (Private)

@interface JTSSettingsViewController ()

@end

#pragma mark - JTSSettingsViewController

@implementation JTSSettingsViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"SettingsTitle", nil)];
    
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:kSettingsCellIdentifier];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:kSettingsSwitchCellIdentifier];
    
    UIBarButtonItem *closeBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"CloseButton", @"Button titles") style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    [[self navigationItem] setLeftBarButtonItem:closeBarButtonItem];
    
    NSString *applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *versionNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *buildNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    [footerLabel setTextAlignment:NSTextAlignmentCenter];
    [footerLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];
    [footerLabel setTextColor:[[CSAppearanceManager defaultManager] darkTextColor]];
    [footerLabel setText:[[NSString alloc] initWithFormat:@"%@ %@ (%@)", applicationName, versionNumber, buildNumber]];
    [[self tableView] setTableFooterView:footerLabel];
}

@end

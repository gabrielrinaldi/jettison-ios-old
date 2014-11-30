//
//  JTSSettingsViewController.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 5/10/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#pragma mark JTSSettingsViewController

@interface JTSSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end

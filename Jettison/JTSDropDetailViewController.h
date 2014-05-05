//
//  JTSDropDetailViewController.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

@class JTSDrop;

#pragma mark JTSDropDetailViewController

@interface JTSDropDetailViewController : UIViewController

@property (strong, nonatomic) JTSDrop *drop;
@property (assign, nonatomic) IBOutlet UILabel *messageLabel;

@end

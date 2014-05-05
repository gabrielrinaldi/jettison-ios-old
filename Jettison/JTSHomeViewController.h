//
//  JTSHomeViewController.h
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

@import MapKit;

#pragma mark JTSHomeViewController

@interface JTSHomeViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *dropsMapView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

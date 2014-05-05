//
//  JTSAddDropViewController.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import <BZGFormViewController/BZGTextFieldCell.h>
#import <VPPLocation/VPPLocationController.h>
#import "JTSDrop.h"
#import "JTSAddDropViewController.h"

#pragma mark JTSAddDropViewController (Private)

@interface JTSAddDropViewController ()

@property (strong, nonatomic) BZGTextFieldCell *messageTextFieldCell;

@end

#pragma mark - JTSAddDropViewController

@implementation JTSAddDropViewController

#pragma mark - Getters/Setters

@synthesize messageTextFieldCell;

#pragma mark - Button actions

- (void)addDrop {
    JTSDrop *drop = [[JTSDrop alloc] init];
    [drop setMessage:[[[self messageTextFieldCell] textField] text]];
    [drop setLocation:[[VPPLocationController sharedInstance] currentLocation]];
    
    [drop saveWithCompletion:^(NSDictionary *result, NSError *error) {
        if (error) {
            // TODO: Add error
            NSLog(@"%@", error);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self delegate] addDropViewControllerDidAdd];
            });
        }
    }];
}

- (void)cancelAddDrop {
    [[self delegate] addDropViewControllerDidCancel];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAddDrop)];
    [[self navigationItem] setLeftBarButtonItem:cancelBarButtonItem];
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Drop" style:UIBarButtonItemStylePlain target:self action:@selector(addDrop)];
    [[self navigationItem] setRightBarButtonItem:addBarButtonItem];
    
    
    [self setMessageTextFieldCell:[[BZGTextFieldCell alloc] init]];
    [[[self messageTextFieldCell] label] setText:@"Message"];
    [[self messageTextFieldCell] setShouldChangeTextBlock:^BOOL(BZGTextFieldCell *cell, NSString *newText) {
        if ([newText length] < 1) {
            [cell setValidationState:BZGValidationStateInvalid];
        } else {
            [cell setValidationState:BZGValidationStateValid];
        }
        
        return YES;
    }];
    
    [self setFormCells:[NSMutableArray arrayWithArray:@[ self.messageTextFieldCell, self.messageTextFieldCell ]]];
}

- (void)dealloc {
    [[VPPLocationController sharedInstance] pauseUpdatingLocation];
}

@end

//
//  LobViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/6/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"



@interface LobViewController : UIViewController<UISplitViewControllerDelegate,UIPopoverControllerDelegate>
{

    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;


- (IBAction)busesBtn:(id)sender;

- (IBAction)hcvcargoBtn:(id)sender;

- (IBAction)imcvtrucksBtn:(id)sender;


- (IBAction)lcvBtn:(id)sender;

- (IBAction)mhcvBtn:(id)sender;



- (IBAction)pickupsBtn:(id)sender;

- (IBAction)scvcargoBtn:(id)sender;

- (IBAction)scvpassBtn:(id)sender;

- (IBAction)scpassBtn:(id)sender;

- (IBAction)pcventureBtn:(id)sender;




@end

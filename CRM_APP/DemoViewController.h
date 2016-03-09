//
//  DemoViewController.h
//  CRM_APP
//
//  Created by admin on 15/09/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoViewController : UIViewController<UISplitViewControllerDelegate,UIPopoverControllerDelegate>


@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;

@end

//
//  ActvityDetailTableviewcellTableViewCell.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/14/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"

@interface ActvityDetailTableviewcellTableViewCell : UITableViewCell
{

    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;

}
@property (weak, nonatomic) IBOutlet UILabel *lbl_Planned_Date;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Activity_Type;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Activity_Status;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Description;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Planned_Time;

@property (strong, nonatomic) IBOutlet UIView *activity_main_view;


@property (weak, nonatomic) IBOutlet UIButton *activittyDonebtn;


@property (weak, nonatomic) IBOutlet UIButton *activityUpdateBtn;






@end

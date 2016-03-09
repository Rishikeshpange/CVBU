//
//  AssignViewController.h
//  CRM_APP
//
//  Created by admin on 19/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"

@interface AssignViewController : UIViewController
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    UpdateACtivity *updateActivty;

}
@property (weak, nonatomic) IBOutlet UIView *assingView;


@property (weak, nonatomic) IBOutlet UIView *container;

@property (weak, nonatomic) IBOutlet UILabel *lab_contact_name;

@property (weak, nonatomic) IBOutlet UILabel *lbl_date;

@property (weak, nonatomic) IBOutlet UILabel *lbl_product_name;

@property (weak, nonatomic) IBOutlet UILabel *lbl_phone_no;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Sales_Stages;

@property (strong, nonatomic) IBOutlet UIButton *btn_Assign;

- (IBAction)btn_Assign:(id)sender;


@end

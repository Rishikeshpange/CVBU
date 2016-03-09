//
//  UpdateAccountController.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 03/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface UpdateAccountController : UIViewController {
    UserDetails_Var* userDetailsVal_;
    AppDelegate* appdelegate;
    UpdateAccount* updateAccount;
}
@property (weak, nonatomic) IBOutlet UITextField* txtMobileNo;

@property (weak, nonatomic) IBOutlet UITextField* txtName;

@property (weak, nonatomic) IBOutlet UIView* viewAccountType;

@property (weak, nonatomic) IBOutlet UIButton* btnSave;

@property (weak, nonatomic) IBOutlet UIButton* btnCancel;

@property (strong, nonatomic) NSString* tgmName;

- (IBAction)btnSave:(id)sender;

- (IBAction)btnCancel:(id)sender;

//- (IBAction)btnSearch:(id)sender;
// Active InACtive Actions :
- (IBAction)btnActive:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton* btnInActive;
- (IBAction)btnInActive:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton* btnActive;

@end

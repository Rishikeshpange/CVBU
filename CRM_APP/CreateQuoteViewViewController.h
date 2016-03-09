//
//  CreateQuoteViewViewController.h
//  DSE
//
//  Created by Rishikesh on 08/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"

@interface CreateQuoteViewViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate ,UITextFieldDelegate>
{
UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}
@property (weak, nonatomic) IBOutlet UITextField *Account_Name_txt_field;
@property (weak, nonatomic) IBOutlet UITextField *Location_txt_field;
@property (weak, nonatomic) IBOutlet UITextField *Phone_Number_txt_field;
@property (weak, nonatomic) IBOutlet UITextField *Postal_Code_txt_field;
@property (weak, nonatomic) IBOutlet UITextField *state_txt_field;
@property (strong, nonatomic) IBOutlet NSString *Address_Id;
@property (weak, nonatomic) IBOutlet UIButton *SAVEBTN;
@property (weak, nonatomic) IBOutlet UIButton *CANCELBTN;

@property(strong,nonatomic)NSMutableArray *showStates;

@end

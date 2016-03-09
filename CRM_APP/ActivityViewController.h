//
//  ActivityViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/13/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"

@interface ActivityViewController : UIViewController<UIActionSheetDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;

}

@property(strong,nonatomic)NSMutableArray *activityType_PickerArr;
@property(strong,nonatomic)NSMutableArray *activityCreate_Arr;


@property (strong, nonatomic) IBOutlet UIButton *btn_Save;

@property (weak, nonatomic) IBOutlet UIView *activity_typeview;

@property (strong, nonatomic) IBOutlet UIButton *btn_Cancel;


@property (weak, nonatomic) IBOutlet UITextField *textfieldType;
- (IBAction)btnActivityType:(id)sender;


- (IBAction)btnDate:(id)sender;

- (IBAction)btn_TIme:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *txt_Selectdate;

@property (strong, nonatomic) IBOutlet UITextField *txt_SelectTime;

@property (weak, nonatomic) IBOutlet UITextView *txtDisc;

@property(strong,nonatomic)NSString *optyid;

@property(strong,nonatomic)NSString *contactID;






@end

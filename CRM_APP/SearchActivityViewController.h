//
//  SearchActivityViewController.h
//  CRM_APP
//
//  Created by admin on 23/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface SearchActivityViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,UISplitViewControllerDelegate,UIPopoverControllerDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    Search_Activitiesresultpage_variables *search_activitiesresultpage_variables; // use of create singleton objects and use its variables for search activities
    UIPickerView *ActivitiesPickerView;
    UIDatePicker *dateSectionView;
    
    UIActionSheet *actionSheet; // ACtionsheet
    
    UIDatePicker *datePicker; //ui date picker for picking date
    NSDate *selectedDate; // ui picker select date
    BOOL isTodateSelected,isFromdateSelected; // for checking which date has been selected
    BOOL isPPLNameclicked,isActivitystatusClicked,isActivityTypeClicked;

}
// Neev TGM TKM

@property (strong, nonatomic) IBOutlet UIButton *img_TGM;

@property (strong, nonatomic) IBOutlet UILabel *lbl_TGM;

@property (strong, nonatomic) IBOutlet UIButton *img_TKM;

@property (strong, nonatomic) IBOutlet UILabel *lbl_TKM;

@property (strong, nonatomic) IBOutlet UIView *view_show;

// All UITextFileds

@property (strong, nonatomic) IBOutlet UITextField *txt_FromDate;

@property (strong, nonatomic) IBOutlet UITextField *txt_ActivityType;

@property (strong, nonatomic) IBOutlet UITextField *txt_AssignTo;

@property (strong, nonatomic) IBOutlet UITextField *txt_PPL;

@property (strong, nonatomic) IBOutlet UITextField *txt_ToDate;

@property (strong, nonatomic) IBOutlet UITextField *txt_Status;

@property (strong, nonatomic) IBOutlet UITextField *txt_Taluka;


// All UIbuttons IBAction

- (IBAction)btn_FromDate:(id)sender;

- (IBAction)btn_ActivityType:(id)sender;

- (IBAction)btn_AssignTo:(id)sender;

- (IBAction)btn_PPL:(id)sender;

- (IBAction)btn_ToDate:(id)sender;

- (IBAction)btn_Status:(id)sender;

- (IBAction)btn_Taluka:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_Search;

- (IBAction)btn_Search:(id)sender;

- (IBAction)btn_Clear:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_Clear;

- (IBAction)btnActive:(id)sender;

- (IBAction)btnInActive:(id)sender;

// All NSMUtable

@property(strong,nonatomic)NSMutableArray *activityPPLNamePickerArr;
@property(strong,nonatomic)NSMutableArray *activitypplIDPickerArr;
@property(strong,nonatomic)NSMutableArray *activityType_PickerArr;
@property(strong,nonatomic)NSMutableArray *activityStatus;
@property(strong,nonatomic)NSMutableArray *activityTaluka;

@property(strong,nonatomic)NSMutableArray *activityAssignTo;
@property(strong,nonatomic)NSMutableArray*_activityAssingTo;
@property(strong,nonatomic)NSMutableArray *activityAssignLOB;

@end

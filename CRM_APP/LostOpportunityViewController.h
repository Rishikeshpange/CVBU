//
//  LostOpportunityViewController.h
//  CRM_APP
//
//  Created by admin on 14/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"

@interface LostOpportunityViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UITextViewDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;

}
// Uilables

@property (strong, nonatomic) IBOutlet UILabel *lbl_ContactName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_contactnumber;

@property (strong, nonatomic) IBOutlet UIView *view_Main;

@property (strong, nonatomic) IBOutlet UIView *view_ShowDetails;

// Uitextfileds

@property (strong, nonatomic) IBOutlet UITextField *txt_ReasonLost;

@property (strong, nonatomic) IBOutlet UITextField *txt_MakeLost;

@property (strong, nonatomic) IBOutlet UITextField *txt_ModeLost;

//@property (strong, nonatomic) IBOutlet UITextField *txt_Description;

@property (strong, nonatomic) IBOutlet UITextView *txt_Description;


// UIButton

@property (strong, nonatomic) IBOutlet UIButton *btn_Save;

- (IBAction)btn_Save:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_Clear;


// UIbutton

- (IBAction)btn_ReasonLost:(id)sender;

- (IBAction)btn_MakeLost:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_ModeLost;

- (IBAction)btn_ModeLost:(id)sender;


- (IBAction)btn_Clear:(id)sender;

// Mutable array

@property(strong,nonatomic)NSMutableArray *ReasonLostOptyArr;
@property(strong,nonatomic)NSMutableArray *ModeofLostArr;
@property(strong,nonatomic)NSMutableArray *MakeLostOptyArr;

@property(strong,nonatomic)NSMutableArray *MakeLostSalesStageArr;

@end

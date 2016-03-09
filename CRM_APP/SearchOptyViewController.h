//
//  SearchOptyViewController.h
//  CRM_APP
//
//  Created by Admin on 24/01/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"
@interface SearchOptyViewController : UIViewController<UIActionSheetDelegate>

{
    UIPickerView *SalestagePickerView;
    UIDatePicker *dateSectionView;
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    UIActionSheet *actionSheet; // ACtionsheet
    UIDatePicker *datePicker; //ui date picker for picking date
    NSDate *selectedDate;
}

@property(strong,nonatomic)NSMutableArray *saleStagePickerArr;
@property(strong,nonatomic)NSMutableArray *pplNamePickerArr;
@property(strong,nonatomic)NSMutableArray *ppl_ID_PickerArr;
@property(strong,nonatomic)NSMutableArray *SalesTaluka_PickerArr;
@property(strong,nonatomic)NSMutableArray *SalesAssignTo_PickerArr;
@property(strong,nonatomic)NSMutableArray *SalesAssignTo_PickerArr_Static;
@property(strong,nonatomic)NSMutableArray *SalesAssignToID;
@property (weak, nonatomic) IBOutlet UIView *viewFirst;
@property(strong,nonatomic)NSMutableArray *SearchOpportunityListArray;
@property (weak, nonatomic) IBOutlet UIView *viewSecond;
//Financier_List_PickerArr
@property(strong,nonatomic)NSMutableArray *Financier_List_PickerArr;
@property(strong,nonatomic)NSMutableArray *Assignlobid_PickerArr;


@property (weak, nonatomic) IBOutlet UIButton *btnSearch;


@property (weak, nonatomic) IBOutlet UITextField *txtCustomerName;

@property (weak, nonatomic) IBOutlet UITextField *txtCustomerMobile;

@property (weak, nonatomic) IBOutlet UITextField *txtFromDate;

@property (weak, nonatomic) IBOutlet UITextField *txtSalesStage;

@property (weak, nonatomic) IBOutlet UITextField *txtTaluka;

@property (weak, nonatomic) IBOutlet UITextField *txtToDate;

@property (weak, nonatomic) IBOutlet UITextField *txtPPL;

@property (weak, nonatomic) IBOutlet UITextField *txtAssignTO;

@property (strong, nonatomic) IBOutlet UITextField *txtFinancier;


@property (weak, nonatomic) IBOutlet UIButton *btnTGM;

@property (weak, nonatomic) IBOutlet UIButton *btnTKM;

- (IBAction)btnSearch:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnClear;

- (IBAction)btnClear:(id)sender;


// button actions

- (IBAction)btnSalesStage:(id)sender;

- (IBAction)btnPPL:(id)sender;

- (IBAction)btnTaluka:(id)sender;

- (IBAction)btnAssignTo:(id)sender;

- (IBAction)btn_Financier:(id)sender;

// Date Picker buttons :

- (IBAction)btnFromDate:(id)sender;

- (IBAction)btnToDate:(id)sender;

// View's

@property (weak, nonatomic) IBOutlet UIView *FirstView;

@property (weak, nonatomic) IBOutlet UIView *SecondView;

//- (IBAction)TGMbtnaction:(id)sender;
//
//- (IBAction)TKMbtnaction:(id)sender;

//Assignlobid_PickerArr


- (IBAction)TGMbtnAction:(id)sender;

- (IBAction)TKMbtnaction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *customermobilelabel;






@end

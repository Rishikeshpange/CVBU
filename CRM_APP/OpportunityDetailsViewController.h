//
//  OpportunityDetailsViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 9/23/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"

@interface OpportunityDetailsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}
//view
@property (weak, nonatomic) IBOutlet UIView *opportunity_view;

@property (weak, nonatomic) IBOutlet UIView *Contact_view;

@property (weak, nonatomic) IBOutlet UIView *Account_view;

@property (weak, nonatomic) IBOutlet UIView *Activity_view;



// Detail menu buttons



//opty details labels

//opty

@property (weak, nonatomic) IBOutlet UILabel *lbl_optyID;

@property (weak, nonatomic) IBOutlet UILabel *lbl_customerCellno;

@property (weak, nonatomic) IBOutlet UILabel *lbl_optyCreationdate;

@property (weak, nonatomic) IBOutlet UILabel *lbl_salesStagename;

@property (weak, nonatomic) IBOutlet UILabel *lbl_productName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_financiername;


//Contact details


@property (weak, nonatomic) IBOutlet UILabel *lbl_contactName;

@property (weak, nonatomic) IBOutlet UILabel *lbl_contactCellno;

@property (weak, nonatomic) IBOutlet UILabel *lbl_contactAddress;


//Account Details


@property (weak, nonatomic) IBOutlet UILabel *lbl_Accountname;

@property (weak, nonatomic) IBOutlet UILabel *lbl_AccountcustomerCellno;


//Activity Details

@property (weak, nonatomic) IBOutlet UILabel *lbl_activityPendingdate;


@property (weak, nonatomic) IBOutlet UILabel *lbl_doneActivitydate;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Acctivitytype;


@property (weak, nonatomic) IBOutlet UILabel *lbl_doneActivitytype
;


@property (weak, nonatomic) IBOutlet UILabel *lbl_pendingActivitydescription;

@property (weak, nonatomic) IBOutlet UILabel *lbl_doneActivitydescription;



@property (weak, nonatomic) IBOutlet UIView *optytitle_view;

@property (weak, nonatomic) IBOutlet UIView *contacttitle_view;


@property (weak, nonatomic) IBOutlet UIView *accounttitle_view;

@property (weak, nonatomic) IBOutlet UIView *activitytitle_view;



// NSMutable

@property(strong,nonatomic)NSMutableArray *ProductDetailsUpdate_Arr;

@property(strong,nonatomic)NSMutableArray *Linkcampaignname;
@property(strong,nonatomic)NSMutableArray *LinkcampaignID;

//detail menu button

@property (weak, nonatomic) IBOutlet UIView *DSMMENU_view;

@property (weak, nonatomic) IBOutlet UIButton *btn_updateDSM;

@property (weak, nonatomic) IBOutlet UIButton *btn_assignDSM;

@property (weak, nonatomic) IBOutlet UIButton *btn_linkCampaignDSM;

@property (weak, nonatomic) IBOutlet UIButton *btn_lostDSM;

@property (weak, nonatomic) IBOutlet UIButton *btn_pendingDSM;

@property (weak, nonatomic) IBOutlet UIButton *btn_newAcxtivityDSM;




@property (weak, nonatomic) IBOutlet UIView *NEEVMENU_view;

@property (weak, nonatomic) IBOutlet UIButton *btn_updateNEEV;

@property (weak, nonatomic) IBOutlet UIButton *btn_createquoteNEEV;

@property (weak, nonatomic) IBOutlet UIButton *btn_assignNEEV;

@property (weak, nonatomic) IBOutlet UIButton *btn_lostNEEV;

@property (weak, nonatomic) IBOutlet UIButton *btn_pendingNEEV;

@property (weak, nonatomic) IBOutlet UIButton *btn_newAcxtivityNEEV;



  //

@property(strong,nonatomic)NSMutableArray *LinkCampaignList;
@property (strong, nonatomic) IBOutlet NSString *selectedLinkCampaignValue;







@property (weak, nonatomic) IBOutlet UIView *DSEMENU_view;

@property (weak, nonatomic) IBOutlet UIButton *btn_updateDSE;

@property (weak, nonatomic) IBOutlet UIButton *btn_createquoteDSE;

@property (weak, nonatomic) IBOutlet UIButton *btn_linkCampaignDSE;

@property (weak, nonatomic) IBOutlet UIButton *btn_lostDSE;

@property (weak, nonatomic) IBOutlet UIButton *btn_pendingDSE;

@property (weak, nonatomic) IBOutlet UIButton *btn_newAcxtivityDSE;



////DSE ACTIONS


- (IBAction)DSEupdateAction:(id)sender;

- (IBAction)DSEpendingAction:(id)sender;

- (IBAction)DSElinkcampaignAction:(id)sender;
- (IBAction)DSElostAction:(id)sender;
- (IBAction)DSEquoteAction:(id)sender;
- (IBAction)DSEactivityAction:(id)sender;


//DSM ACTIONS


- (IBAction)DSMupdateAction:(id)sender;
- (IBAction)DSMassignAction:(id)sender;
- (IBAction)DSMlinkcampaignAction:(id)sender;
- (IBAction)DSMlostAction:(id)sender;
- (IBAction)DSMactivityAction:(id)sender;
- (IBAction)DSMpendingAction:(id)sender;









@end

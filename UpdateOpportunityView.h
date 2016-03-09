//
//  UpdateOpportunityView.h
//  DSE
//
//  Created by Rishikesh on 13/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UpdateOpportunityView : UIViewController<UITextFieldDelegate>
{
    AppDelegate *appdelegate;
}

@property (weak, nonatomic) IBOutlet UITextField *LOBTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *PPLTextField;
@property (weak, nonatomic) IBOutlet UITextField *PLTextField;
@property (weak, nonatomic) IBOutlet UITextField *ApplicationTextField;
@property (weak, nonatomic) IBOutlet UIButton *LOBDropDown;
@property(strong,nonatomic) IBOutlet  AppDelegate *appdelegate;

@property(strong,nonatomic) IBOutlet  NSString *ProductString;
@property(strong,nonatomic) IBOutlet  NSString *PRODUCT_IDstring;

@property (strong, nonatomic) IBOutlet NSMutableArray *opp_Contact_LOB_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *PPL_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *PL_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *Application_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *Product_Arr;

@property(strong,nonatomic) IBOutlet  NSString *DetailPageOpty_ID;

@property (weak, nonatomic) IBOutlet UIButton *SAVEBTN;
@property (weak, nonatomic) IBOutlet UIButton *CANCELBTN;


@property (weak, nonatomic) IBOutlet UIButton *btnSave;//abhishek

@property(strong,nonatomic) IBOutlet  NSString *lobstring;
@property(strong,nonatomic) IBOutlet  NSString *pplstring;
@property(strong,nonatomic) IBOutlet  NSString *plstring;
@property(strong,nonatomic) IBOutlet  NSString *applicationstring;



-(void)showAlert; //Abhishek
-(void)hideAlert; //Abhishek


@end

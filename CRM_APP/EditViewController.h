//
//  EditViewController.h
//  CRM_APP
//
//  Created by Preeti Sakhare on 10/7/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MLPAutoCompleteTextFieldDelegate.h"
#import "AppDelegate.h"

@class DEMODataSource;
@class MLPAutoCompleteTextField;

@interface EditViewController : UIViewController<UITextFieldDelegate, MLPAutoCompleteTextFieldDelegate>
{
     AppDelegate *appdelegate;

}
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *cellnumber;
@property (weak, nonatomic) IBOutlet UITextField *emailid;
@property (strong, nonatomic) IBOutlet NSMutableDictionary *dict;
@property (weak, nonatomic) IBOutlet UITextField *Area;
@property (weak, nonatomic) IBOutlet UITextField *State;
@property (weak, nonatomic) IBOutlet UITextField *District;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet UITextField *Taluka;
@property (weak, nonatomic) IBOutlet UITextField *Panchayat;

@property (weak, nonatomic) IBOutlet UITextField *Lob;
@property (weak, nonatomic) IBOutlet UITextField *PPL;
@property (weak, nonatomic) IBOutlet UITextField *PL;
@property (weak, nonatomic) IBOutlet UITextField *Application;
@property (weak, nonatomic) IBOutlet UITextField *Financier;

@property (strong, nonatomic) IBOutlet NSMutableArray *District_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *City_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *Taluka_List_PickerArr;

@property (strong, nonatomic) IBOutlet DEMODataSource *autocompleteDataSource;
@property (weak) IBOutlet MLPAutoCompleteTextField *autocompleteTextField;


@property (strong, nonatomic) IBOutlet UILabel *demoTitle;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSwitch;


@property (strong) NSManagedObject *Editdetail;

-(NSMutableArray *)get; 



@end

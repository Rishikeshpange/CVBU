//
//  Search_OpportunityList_Var.h
//  DSM
//
//  Created by Sachin Sharma on 24/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//



#import <Foundation/Foundation.h>

extern NSMutableArray *SearchOpportunityListArray;
extern NSMutableArray *DisplaySearchOpportunityDetailsArray;

@interface Search_OpportunityList_Var : NSObject
{
    
}

/*
 
 <TABLE>
 <OPTY_NAME>5 ABHIJEET5 1-7A2B84A # 1</OPTY_NAME>
 <OPTY_ID>1-7A3BETX</OPTY_ID>
 <PRODUCT_NAME1>LP613 FBV</PRODUCT_NAME1>
 <OPTY_CREATED_DATE>07-NOV-2014</OPTY_CREATED_DATE>
 <PRODUCT_ID>1-19LT3R4</PRODUCT_ID>
 <VC>26433538000LYD20</VC>
 <TGM_TKM_NAME xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <TGM_TKM_PHONE_NUMBER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <ACCOUNT_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <ACCOUNT_TYPE xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <SALES_STAGE_NAME>C0 (Prospecting)</SALES_STAGE_NAME>
 <SALE_STAGE_UPDATED_DATE>02-FEB-2015</SALE_STAGE_UPDATED_DATE>
 <LEAD_ASSIGNED_NAME>RAMANADEEPHAN M</LEAD_ASSIGNED_NAME>
 <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
 <LEAD_POSITION>TMCV-Sal-S-TN3-1004150-Coimbatore-ACE-DSE-C</LEAD_POSITION>
 <LEAD_ASSIGNED_POSITION_ID>1-8RH323</LEAD_ASSIGNED_POSITION_ID>
 <CONTACT_NAME>5 ABHIJEET5</CONTACT_NAME>
 <CONTACT_FIRST_NAME>5</CONTACT_FIRST_NAME>
 <CONTACT_LAST_NAME>ABHIJEET5</CONTACT_LAST_NAME>
 <CONTACT_ID>1-7A2B84A</CONTACT_ID>
 <CONTACT_ADDRESS xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <ADDRESS_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <CONTACT_CELL_NUMBER>1234567894</CONTACT_CELL_NUMBER>
 <LAST_PENDING_ACTIVITY_TYPE>Call Customer</LAST_PENDING_ACTIVITY_TYPE>
 <LAST_PENDING_ACTIVITY_ID>1-7BNL07H</LAST_PENDING_ACTIVITY_ID>
 <LAST_PENDING_ACTIVITY_STATUS>Open</LAST_PENDING_ACTIVITY_STATUS>
 <LAST_PEND_ACTIVIY_START_DATE>30-JAN-2015 12:09:14</LAST_PEND_ACTIVIY_START_DATE>
 <LAST_PENDING_ACTIVITY_DESC>TT</LAST_PENDING_ACTIVITY_DESC>
 <LAST_DONE_ACTIVITY_TYPE xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <LAST_DONE_ACTIVITY_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <LAST_DONE_ACTIVITY_DATE xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <LAST_DONE_ACTIVITY_DESC xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <PRODUCT_NAME>LCV Buses</PRODUCT_NAME>
 <CUSTOMER_ACCOUNT_NAME xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <CUSTOMER_ACCOUNT_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <CUSTOMER_ACCOUNT_MOBNUMBER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <REV_PRODUCT_ID>1-7A3E14H</REV_PRODUCT_ID>
 </TABLE>
 */

@property(nonatomic,strong)NSString* OPTY_ID;
@property(nonatomic,strong)NSString* OPTY_NAME;
@property(nonatomic,strong)NSString* OPTY_CREAT_DATE;
@property(nonatomic,strong)NSString* PRODUCT_NAME1;
@property(nonatomic,strong)NSString* PRODUCT_ID;
@property(nonatomic,strong)NSString* VC;
@property(nonatomic,strong)NSString* TGM_TKM_NAME;
@property(nonatomic,strong)NSString* TGM_TKM_PHONE_NUMBER;
@property(nonatomic,strong)NSString* ACCOUNT_ID;
@property(nonatomic,strong)NSString* ACCOUNT_TYPE;
@property(nonatomic , strong)NSString *SALES_STAGE_DATE;
@property(nonatomic , strong)NSString *SALE_STAGE_NAME;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_NAME;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_CELL_NUMBER;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_POSITION;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_POSITION_ID;
@property(nonatomic,strong)NSString* CONTACT_NAME;
@property(nonatomic,strong)NSString* CONTACT_FIRST_NAME;
@property(nonatomic,strong)NSString* CONTACT_LAST_NAME;
@property(nonatomic,strong)NSString* CONTACT_ID;
@property(nonatomic,strong)NSString* CONTACT_ADDRESS;
@property(nonatomic,strong)NSString* ADDRESS_ID;
@property(nonatomic,strong)NSString* CONTACT_CELL_NUMBER;
@property(nonatomic,strong)NSString* LAST_PENDING_ACTIVITY_TYPE;
@property(nonatomic,strong)NSString* LAST_PENDING_ACTIVITY_ID;
@property(nonatomic,strong)NSString* LAST_PENDING_ACTIVITY_STATUS;
@property(nonatomic,strong)NSString* LAST_PEND_ACTIVIY_START_DATE;
@property(nonatomic,strong)NSString* LAST_PENDING_ACTIVITY_DESC;
@property(nonatomic,strong)NSString* LAST_DONE_ACTIVITY_TYPE;
@property(nonatomic,strong)NSString* LAST_DONE_ACTIVITY_ID;
@property(nonatomic,strong)NSString* LAST_DONE_ACTIVITY_DATE;
@property(nonatomic,strong)NSString* LAST_DONE_ACTIVITY_DESC;
@property(nonatomic,strong)NSString* X_TALUKA;
@property(nonatomic,strong)NSString* PRODUCT_NAME;
@property(nonatomic,strong)NSString* CUSTOMER_ACCOUNT_NAME;
@property(nonatomic,strong)NSString* CUSTOMER_ACCOUNT_ID;
@property(nonatomic,strong)NSString* CUSTOMER_ACCOUNT_MOBNUMBER;
@property(nonatomic,strong)NSString* REV_PRODUCT_ID;

//Rishikesh
@property(nonatomic,strong)NSString* ACCOUNT_PHONE_NUMBER;
@property(nonatomic,strong)NSString* ACCOUNT_NAME;
@property(nonatomic,strong)NSString* ACCOUNT_LOCATION;
@property(nonatomic,strong)NSString* RNUM;
@property(nonatomic,strong)NSString* RESULT_COUNT;

@property(nonatomic,strong)NSString* MAKE_LOST_TO;
@property(nonatomic,strong)NSString* MODEL_LOST_TO;
@property(nonatomic,strong)NSString* CLOSURE_SUMMARY;
@property(nonatomic,strong)NSString* REASON_LOST;

@property(nonatomic,strong)NSString* PRODUCT_LINE;
@property(nonatomic,strong)NSString* PARENT_PROD_LINE;

@property(nonatomic,strong)NSString*OPTY_CREATED_DATE;
@property(nonatomic,strong)NSString*LEAD_POSITION;
@property(nonatomic,strong)NSString*CUSTOMER_ACCOUNT_LOCATION;
@property(nonatomic,strong)NSString*CUSTOMER_PHONE_NUMBER;
@property(nonatomic,strong)NSString*PPL;
@end
extern Search_OpportunityList_Var *searchOppListVar;


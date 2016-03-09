//
//  Opportunity_List.h
//  sfa
//
//  Created by Admin on 27/02/14.
//  Copyright (c) 2014 ttl. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSMutableArray *OpportunityListArr,*OpportunityList_ArrList;
extern NSMutableArray *OpportunityListDisplayArr;

@interface Opportunity_List : NSObject
{
   
}
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
@property(nonatomic,strong)NSString* REV_PRODUCT_ID;
@property(nonatomic,strong)NSString* LEAD_POSITION;
@property(nonatomic , strong)NSString *RNUM;
@property(nonatomic , strong)NSString *RESULT_COUNT;
@property(nonatomic , strong)NSString *ACCOUNT_NAME;
@property(nonatomic , strong)NSString *CUSTOMER_PHONE_NUMBER;
@property(nonatomic , strong)NSString *CUSTOMER_ACCOUNT_LOCATION;

@property(nonatomic , strong)NSString  *OPTY_CREATED_DATE;
@property(nonatomic , strong)NSString  *CUSTOMER_ACCOUNT_MOBNUMBER;

@property(nonatomic , strong)NSString  *FIN_NAME;


@end
extern Opportunity_List *opportunity_list,*searchOpportunity_list;
//
//  PendingActivityList.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/14/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "PendingActivityList.h"




PendingActivityList *activityPending_list;
NSMutableArray *pendingActivities_ListArr,*pendingActivities_Customer_list;
NSMutableArray *pendingActivities_ListDisplayArr;
@implementation PendingActivityList

@synthesize ACTIVITY_PLAN_START_DT,ACTIVITY_TYPE,ACTIVITY_ID,ACTIVITY_STATUS,ACTIVITY_DESC,TGM_TKM_NAME,TGM_TKM_PHONE_NUMBER,ACCOUNT_ID,CONTACT_NAME,CONTACT_ID,CONTACT_ADDRESS,CONTACT_CELL_NUMBER,OPTY_ID,OPTY_NAME,OPTY_CREATED,SALES_STAGE_NAME,SALE_STAGE_UPDATED_DATE,LEAD_POSITION,LEAD_ASSIGNED_NAME,LEAD_ASSIGNED_CELL_NUMBER,X_PROSPECT_SRC,ACTIVITY_PLAN_START_TM,RESULT_COUNT;

@end


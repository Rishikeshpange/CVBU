//
//  PendingActivityList.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/14/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PendingActivityList : NSObject


@property(nonatomic , strong)NSString *ACTIVITY_PLAN_START_DT;
@property(nonatomic , strong)NSString *ACTIVITY_TYPE;
@property(nonatomic , strong)NSString *ACTIVITY_ID;
@property(nonatomic , strong)NSString *ACTIVITY_STATUS;
@property(nonatomic , strong)NSString *ACTIVITY_DESC;
@property(nonatomic , strong)NSString *TGM_TKM_NAME;
@property(nonatomic , strong)NSString *TGM_TKM_PHONE_NUMBER;
@property(nonatomic , strong)NSString *ACCOUNT_ID;
@property(nonatomic , strong)NSString *CONTACT_NAME;
@property(nonatomic , strong)NSString *CONTACT_ID;
@property(nonatomic , strong)NSString *CONTACT_ADDRESS;
@property(nonatomic , strong)NSString *CONTACT_CELL_NUMBER;
@property(nonatomic , strong)NSString *OPTY_NAME;
@property(nonatomic , strong)NSString *OPTY_ID;
@property(nonatomic , strong)NSString *OPTY_CREATED;
@property(nonatomic , strong)NSString *SALES_STAGE_NAME;
@property(nonatomic , strong)NSString *SALE_STAGE_UPDATED_DATE;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_NAME;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_CELL_NUMBER;
@property(nonatomic , strong)NSString *LEAD_POSITION;
@property(nonatomic , strong)NSString *LEAD_POSITION_ID;
@property(nonatomic , strong)NSString *X_PROSPECT_SRC;
@property(nonatomic , strong)NSString *RESULT_COUNT;

@property(nonatomic , strong)NSString *ACTIVITY_PLAN_START_TM;
//ACTIVITY_PLAN_START_TM
@end
extern PendingActivityList *activityPending_list;


extern NSMutableArray *pendingActivities_ListArr;
extern NSMutableArray *pendingActivities_Customer_list;
extern NSMutableArray *pendingActivities_ListDisplayArr;
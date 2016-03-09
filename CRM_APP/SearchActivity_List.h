//
//  SearchActivity_List.h
//  sfa
//
//  Created by Admin on 08/04/14.
//  Copyright (c) 2014 ttl. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSMutableArray *SearchActivitiesListArray;
extern NSMutableArray *DisplaySearchActivitiesDetailsArray;

@interface SearchActivity_List : NSObject
{
    
}


@property(nonatomic , strong)NSString *X_PROSPECT_SRC;
@property(nonatomic , strong)NSString *ACTIVITY_ROW_ID;
@property(nonatomic , strong)NSString *ACTIVITY_TYPE;
@property(nonatomic , strong)NSString *ACTIVITY_PLAN_START_DATE;
@property(nonatomic , strong)NSString *ACTIVITY_CREATED_DATE;
@property(nonatomic , strong)NSString *ACTIVITY_COMPLETION_DATE;
@property(nonatomic , strong)NSString *ACTIVITY_STATUS;
@property(nonatomic , strong)NSString *DESCRIPTION;
@property(nonatomic , strong)NSString *OPTY_CREAT_DATE;
@property(nonatomic , strong)NSString *OPPTY_ROWID;
@property(nonatomic , strong)NSString *OPPTY_NAME;
@property(nonatomic , strong)NSString *PRODUCT_LINE;
@property(nonatomic , strong)NSString *PARENT_PRODUCT_NAME;
@property(nonatomic , strong)NSString *VC;
@property(nonatomic , strong)NSString *CONTACT_ID;
@property(nonatomic , strong)NSString *CONTACT_NAME;
@property(nonatomic , strong)NSString *CONTACT_CELL_NUM;
@property(nonatomic , strong)NSString *CONTACT_ADDRESS;
@property(nonatomic , strong)NSString *ADDRESS_ID;
@property(nonatomic , strong)NSString *ACCOUNT_ID;
@property(nonatomic , strong)NSString *ACCOUNT_NAME;
@property(nonatomic , strong)NSString *ACCOUNT_PHONE_NUMBER;
@property(nonatomic , strong)NSString *ACCOUNT_LOCATION;
@property(nonatomic , strong)NSString *SALES_STAGE_DATE;
@property(nonatomic , strong)NSString *SALE_STAGE;
@property(nonatomic , strong)NSString *RNUM;
@property(nonatomic , strong)NSString *RESULT_COUNT;

@end

extern SearchActivity_List *searchActivity_list;











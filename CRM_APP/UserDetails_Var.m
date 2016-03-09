//
//  UserDetails_Var.m
//  SFA
//
//  Created by Admin on 19/02/14.
//  Copyright (c) 2014 ttl. All rights reserved.
//

#import "UserDetails_Var.h"

UserDetails_Var *userDetails;

@implementation UserDetails_Var
@synthesize
Login_Name,
POSITION_NAME,
LOB_NAME,
REGION_NAME,
AREA,
STATE,
ROW_ID,
POSTN,
ORGNAME,PassWord;

+(id)sharedmanager
{
    
    static UserDetails_Var *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
    
}

@end



@implementation SearchOpportunityResultPage_Variables
@synthesize saleStage_,pplName_,fromDate_,todate_;
SearchOpportunityResultPage_Variables  *searchOpportunityResultPage_Variables;

+(id)sharedmanager
{
    static SearchOpportunityResultPage_Variables *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}


@end





@implementation Search_Activitiesresultpage_variables   //search Activity result page
@synthesize pplName_,fromDate_,todate_,activityStatus_,activityType_;
Search_Activitiesresultpage_variables  *search_activitiesresultpage_variables;

+(id)sharedmanager
{
    static Search_Activitiesresultpage_variables *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}

@end




@implementation CreateContactResult
@synthesize Id_ ,IntegrationId_ ,IntegrationId2_;

CreateContactResult *createcontactresult;

+(id)sharedmanager
{
    static CreateContactResult *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}

@end






@implementation CreateContactAginstAccount
@synthesize Id_;

CreateContactAginstAccount *createContactaginstaccount;

+(id)sharedmanager
{
    static CreateContactResult *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}


@end





@implementation CreateQuotationAginstOpportunity
@synthesize Id_,LineItemId_;

CreateQuotationAginstOpportunity *createQuotationAginstOpportunity;

+(id)sharedmanager
{
    static CreateQuotationAginstOpportunity *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}


@end


@implementation CreateAccountAginstContact
@synthesize Id_;

CreateAccountAginstContact *createaccountcginstcontact;

+(id)sharedmanager
{
    static CreateAccountAginstContact *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}


@end


@implementation CreateLostOpportunity
@synthesize Id_;

CreateLostOpportunity *createLostOpportunity;

+(id)sharedmanager
{
    static CreateLostOpportunity *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}

@end



@implementation CreateAccount
@synthesize AccountId_;

CreateAccount *createaccount;

+(id)sharedmanager
{
    static CreateAccount *sharedManager = nil;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}




@end



@implementation PL_ProductID_Product
@synthesize PRODUCT_ , PRODUCT_ID_;

PL_ProductID_Product *pl_productid_product;

+(id)sharedmanager
{
    static PL_ProductID_Product *sharedManager = nil;
    //static dispatch_once_t onceToken;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}
@end


@implementation CreateOpportunity
@synthesize Id_ ;
@synthesize Contact_;

CreateOpportunity *createopportunity;

+(id)sharedmanager
{
    static CreateOpportunity *sharedManager = nil;
    @synchronized(self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}
@end


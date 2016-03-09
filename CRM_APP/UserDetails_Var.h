//
//  UserDetails_Var.h
//  SFA
//
//  Created by Admin on 19/02/14.
//  Copyright (c) 2014 ttl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetails_Var : NSObject
{
    NSString* Login_Name;
    NSString* POSITION_NAME;
    NSString* LOB_NAME;
    NSString* REGION_NAME;
    NSString* AREA;
    NSString* STATE;
    NSString* ROW_ID;
    NSString* POSTN;
    NSString* ORGNAME;
    NSString* PassWord;

   
}
+(id)sharedmanager;
@property(strong,nonatomic)NSString *Login_Name;
@property(strong,nonatomic)NSString *POSITION_NAME;
@property(strong,nonatomic)NSString *LOB_NAME;
@property(strong,nonatomic)NSString *REGION_NAME;
@property(strong,nonatomic)NSString *AREA;
@property(strong,nonatomic)NSString *STATE;
@property(strong,nonatomic)NSString *ROW_ID;
@property(strong,nonatomic)NSString *POSTN;
@property(strong,nonatomic)NSString *ORGNAME;
@property(strong,nonatomic)NSString *PassWord;




@end


@interface SearchOpportunityResultPage_Variables : NSObject // searech opportunity result
{
    NSString* saleStage_;
    NSString* pplName_;
    NSString* fromDate_;
    NSString* todate_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* saleStage_;
@property(strong , nonatomic)NSString* pplName_;
@property(strong , nonatomic)NSString* fromDate_;
@property(strong , nonatomic)NSString* todate_;

@end



@interface Search_Activitiesresultpage_variables: NSObject  //search Activity result page
{
    NSString* pplName_;
    NSString* fromDate_;
    NSString* todate_;
    NSString* activityStatus_;
    NSString* activityType_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* pplName_;
@property(strong , nonatomic)NSString* fromDate_;
@property(strong , nonatomic)NSString* todate_;
@property(strong , nonatomic)NSString* activityStatus_;
@property(strong , nonatomic)NSString* activityType_;
@end






@interface CreateContactResult : NSObject //CreateContact_VC.h page
{
    NSString *Id_;
    NSString *IntegrationId_;
    NSString *IntegrationId2_;
    
}

+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
@property(strong , nonatomic)NSString* IntegrationId_;
@property(strong , nonatomic)NSString* IntegrationId2_;

@end

@interface UpdateOptyProduct : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
    // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;

//@property(strong , nonatomic)NSString* LineItemId_;
@end


@interface UpdateContactOpty : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
    NSString *Id_1;
    // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
@property(strong , nonatomic)NSString* Id_1;

//@property(strong , nonatomic)NSString* LineItemId_;
@end


@interface CreateAccountAginstContact : NSObject // CreateOpportunityViewController.h Page
{
    NSString *Id_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;

@end





@interface CreateContactAginstAccount : NSObject // CreateContactWithAccount_VC.h Page
{
    NSString *Id_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;

@end


@interface UpdateAccount : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
    // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
//@property(strong , nonatomic)NSString* LineItemId_;
@end

@interface CreateAccountQoute : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *AccountId_;
    NSString *AddressId_;
    // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* AccountId_;
@property(strong , nonatomic)NSString* AddressId_;

//@property(strong , nonatomic)NSString* LineItemId_;
@end


@interface ActivityDone : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
    // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
@end

@interface ActivityFinalDone : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
    // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
@end

@interface CreateQuotationAginstOpportunity : NSObject // Opportunity_DetailsVC.h Page
{
    NSString *Id_;
    NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
@property(strong , nonatomic)NSString* LineItemId_;
@end



@interface CreateLostOpportunity : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
   // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
//@property(strong , nonatomic)NSString* LineItemId_;

@end

@interface CreateAccount : NSObject // CreateOpportunityViewController.h Page
{
    NSString *AccountId_;
    NSString *Id_;
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* AccountId_;
@property(strong , nonatomic)NSString* Id_;


@end


@interface PL_ProductID_Product : NSObject // CreateOpportunityViewController.h Page
{
    NSString *PRODUCT_;
    NSString *PRODUCT_ID_;
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* PRODUCT_;
@property(strong , nonatomic)NSString* PRODUCT_ID_;

@end




@interface CreateOpportunity : NSObject // CreateOpportunityViewController Page
{
    NSString *Id_;
    NSString *Contact_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
@property(strong , nonatomic)NSString* Contact_;
@end


@interface UpdateOptyQoute : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
    // NSString *LineItemId_;
    
}
+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;

//@property(strong , nonatomic)NSString* LineItemId_;
@end


@interface UpdateACtivity : NSObject // MakeLostOpportunity_VC.h Page
{
    NSString *Id_;
    // NSString *LineItemId_;
    
}

+(id)sharedmanager;
@property(strong , nonatomic)NSString* Id_;
@end







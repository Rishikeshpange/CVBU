//
//  RequestDelegate.h
//  RetailerPortal
//
//  Created by madhu on 11/20/12.
//  Copyright (c) 2012 madhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
static void *mainViewControllerVC;


@interface RequestDelegate : NSObject
{
    AppDelegate *appdelegate;
    int statusCode;
    
    NSString *NSurl;
    
    NSURLConnection *artifactConnection, *authenticateOIDConnection,*getCurrentDateConnection,*getUserDetailsConnection, *getAllOpportunity,*getCreateoptyfornewcontact,*getAllStatesConnection,*getAllDistrictsConnection,*getAllcitiesconnection,*getAlltalukaconnection,*getActivityTypeConnection,*getActivityCreateConnection,*getLostReasonOpportunityConnection,*getLostMakeOpportunityConnection,*getLostModeOpportunityConnection,*getListOfDSETypeConnection,*getActivitydetailsListfromopty,*getLinkcampaign_Connection,*getLinkcampaign_Select_connection,*getActivityDetails_Connection,*getActivityPPLConnection,*getActivityTaluka,*getSearchOpportunityAssignTo,*getSearchActivitiesConnection,*getCreateQouteConnection,*getQouteCreationupdateOptyConnection,*getupdateOpportunityQouteConnection,*getDoneUPdateOptyLast_Connection,*getQouteCreationConnection,*getQouteCreationupdateOptySales,*getSearchAccountConnection,*AccountUpdate_Connection,*getCreateContacWithAccountDetails_Connection,*getCreateAccountE_Connection,*getAssignOptyConnection,*getActivityDoneConnection,*ActivitiyFinalDoneConnection,*getAllDistrictConnection,*getAllCityConnection,*getAllTalukaConnection,*getAllPincodeConnection,*ProceedToQuoteCreation_connection,*AfterQuoteCreationConnection,*getLostOpportunityConnection,*getSearchActivitiesConnection1,*getSearchActivitiesConnection12,*getupdateActivityConnection,*getActivityPLConnection,*getAppType_connection,*getActivityFinanceConnection,*ContactSave_connection,*adressID_connection,*get_Lob_List_Connection,*get_PPL_List_Connection,*get_PL_List_Connection,*get_Application_List_Connection,*GetProductconnection,*UpdateOptyconnection,*StateAllconnection,*getAddressConnection,*getAllTalukaConnectioncall,*getContactUpdateConnection,*getApplicationbodyTypeconnection,*getCustomerSegmentConnection,*getSalesPipelineDashboardConnection,*getLeadGeneratorwisePipelineViewConnection,*getMMPipeLineView_DSMConnection,*getSalesPipeLineDashboard_DSMConnection,*getSalesPipeLineDashboard_DSEConnection,*getSalesPipelineDashboard_NEEVConnection,*getEventExecutiveDashboard_NEEVConnection,*getEventActive_NEEVConnection,*getSalesPipelineDashboard_NEEVPPLConnection,*getSalesPipelineDashboard_NEEVPLConnection,*getActivityPPLConnectionDSMPLConnection,*getActivityPLDSMConnection,*getSalesPipelineDashboard_DSMPLAllConnection,*getEventDashboard_DSMConnection,*getEventActiveDashboard_DSMConnection,*getgetMMPipeLineView_DSEConnection,*getMMGeoDashboard_DSEConnection,*getProductUpdateConnection,*getdetailsforopportunity,*GetUsageCategoryDSM,*GetBodyTypeDSMconnection,*GetListofActiveMicroMarketDSMconnection,*PL_ProductID_Requestconnection,*CreateoptyforexistingContactConnection,*get_Contact_List_Connection,*getListofsearchOpportunityConnection,*createcontactconnection,*ContactquerybyIDConnection,*prospectupdateconnection,*AssignActivityforopportunityconnection,*pplconnection,
        *getAllPincodeConnectioninCreateOptyVCConnection,*GetALLPPLRelatedProductConnection,*GetCampainDetailsForDSMConnection;
    
    
    
    
    
    
    NSMutableData *artifactData, *authenticateOIDData, *CurrentDateData,*userDetailsData,*SaleAllOpportunity,*Createoptyfornewcontactdata,*AllStatesdata,*AllDistrictsdata,*Allcitiesdata,*Alltalukadata,*ActivityTypedata,*ActivityCreatedata,*ReasonLostOpportunity,*MakeLostOpportunity,*ModeLostOpportunity,*GetListOfDSE,*ActivitydetailsListfromoptydata,*Linkcampaign_Data,*Select_Linkcampaign_Data,*ActivityDetails_Data,*ActivityPPLData,*ActivityTypeData,*ActivityTaluka,*SalesOppAssingTOData,*seachActivitiesData,*GetAllStates,*CreateQouteConnection,*QouteCreationupdateOpty,*UpdateOpportunityQouteConnection,*DoneUPdateOptyLastData,*QouteCreationData,*QouteCreationupdateOptyData,*getSearchAccountData,*AccountUpdateData,*CreateContacWithAccountDetails_Data,*CreateAccount_Data,*GetAssignToDSE,*ActivityDoneData,*ActivitiyFinalDone,*GetAllDistrict,*AllCityDataFind,*GetAllTaluka,*GetAllPincode,*ProceedToQuoteCreationdata,*AfterQuoteCreationData,*MakeTheLostOpportunity,*seachActivitiesData1,*seachActivitiesData12,*PendingActivtyUpdate,*getPLData,*GetAppTypeData,*getFinancier_List_Data,*ContactSavedata, *adressIDdata,*getLobList,*getPPL_List_Data,*getPL_List_Data,*getApplication_List_Data,*GetProductdata,*UpdateOptydata,*StateData,*AddressData,*GetAllTalukacall,*ContactDetailsUpdate,*ApplicationBodyType,*CustomerSegmentData,*SalesPipelineDashboard,*LeadGeneratorwisePipelineView,*MMPipeLineView_DSM,*SalesPipeLineDashboard_DSM,*SalesPipeLineDashboard_DSE,*SalesPipelineDashboard_NEEV,*EventExecutiveDashboard_NEEV,*EventActive_NEEV,*SalesPipelineDashboard_NEEVPPL,*SalesPipelineDashboard_NEEVPL,*ActivityPPLConnectionDSMPL,*ActivityPLDSMConnection,*SalesPipelineDashboard_DSMPLAll,*EventDashboard_DSM,*EventActiveDashboard_DSM,*MMPipeLineView_DSE,*MMGeoDashboard_DSE,*ProductUpdateConnection,*detailsforopportunity,*GetUsageCategoryDSMData,*GetBodyTypeDSMData,*GetListofActiveMicroMarketDSMData,*PL_ProductID_RequestData,*CreateoptyforexistingContactData,*getContact_List_Data,*getListofsearchOpportunityData,*createcontactData,*ContactquerybyIDData,*prospectupdateconnectionData,*AssignActivityforopportunityData,*ppldata , *getAllPincodeConnectioninCreateOptyVCdata,*GetALLPPLRelatedProductdata,*GetCampainDetailsForDSMdata;
}
-(void)initiateRequest:(NSURLRequest*)request name:(NSString*)name;

-(void)CheckSamalArtExpires :(NSString*)str_samalART;



@end

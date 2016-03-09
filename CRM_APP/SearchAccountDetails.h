//
//  SearchAccountDetails.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 18/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchAccountDetails : NSObject
{}
/*
 <tuple>
 <old>
 <S_ORG_EXT>
 <TGM_NAME>RAJEEV</TGM_NAME>
 <TGM_PHONE_NUMBER>789</TGM_PHONE_NUMBER>
 <ACCOUNT_ID>1-7BNIZHZ</ACCOUNT_ID>
 <ACCOUNT_STATUS>Active</ACCOUNT_STATUS>
 </S_ORG_EXT>
 </old>
 </tuple>
 */


@property(nonatomic , strong)NSString *TGM_NAME;
@property(nonatomic , strong)NSString *TGM_PHONE_NUMBER;
@property(nonatomic , strong)NSString *ACCOUNT_ID;
@property(nonatomic , strong)NSString *ACCOUNT_STATUS;


@end
extern SearchAccountDetails *Search_list;
extern NSMutableArray *AccountSearch_ListArr;
extern NSMutableArray *Activities_Customer_list;
//extern NSMutableArray *Activities_ListDisplayArr;
extern NSMutableArray *Activities_ListMonthArr;
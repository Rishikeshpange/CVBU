//
//  AssignViewModel.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 25/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSMutableArray *ListofDSE_Arr;

@interface AssignViewModel : NSObject
{
}
/*
 <S_POSTN>
 <NSE_LOBDSE_NAME>ABHAY GOGATE</NSE_LOBDSE_NAME>
 <POSITION_PH_NUM>9223354582</POSITION_PH_NUM>
 <POSITION_NAME>TMCV-Sal-W-MUM-1001680-Thane-LCV-DSE-15</POSITION_NAME>
 <POSITION_ID>1-14XINH4</POSITION_ID>
 <LOB_NAME>LCV</LOB_NAME>
 <POSTN_TYPE_CD>DSE</POSTN_TYPE_CD>
 <EMP_ID>1-5AR6Q57</EMP_ID>
 <NSEORDSEUSERNAME>AGOGATE_1001680</NSEORDSEUSERNAME>
 </S_POSTN>
 
 */
@property(nonatomic,strong)NSString* NSE_LOBDSE_NAME;
@property(nonatomic,strong)NSString* POSITION_PH_NUM;
@property(nonatomic,strong)NSString* POSITION_NAME;
@property(nonatomic,strong)NSString* POSITION_ID;
@property(nonatomic,strong)NSString* LOB_NAME;
@property(nonatomic,strong)NSString* POSTN_TYPE_CD;
@property(nonatomic,strong)NSString* EMP_ID;
@property(nonatomic,strong)NSString* NSEORDSEUSERNAME;
@end
extern AssignViewModel *assign_list;
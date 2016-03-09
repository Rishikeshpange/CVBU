//
//  SingletonClass.h
//  CRM_APP
//
//  Created by Admin on 03/02/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject
@property(strong,nonatomic)NSMutableArray *GetSalesPipeLineDashboard_DSMPLAll_singleTonArr,*GetPL_PPLDSM_SingletonArr,*GetSalesPipeLineDashboard_DSEPLArrSingleton;

+(SingletonClass*)sharedobject;

@end

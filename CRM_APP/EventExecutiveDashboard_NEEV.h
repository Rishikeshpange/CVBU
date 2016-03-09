//
//  EventExecutiveDashboard_NEEV.h
//  CRM_APP
//
//  Created by admin on 18/11/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventExecutiveDashboard_NEEV : NSObject

/*
 <tuple xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
 <old>
 <S_SRC xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
 <FN>JAYESH KUMAR</FN>
 <LN> C V</LN>
 <DSE_NAME>JKCV3001520</DSE_NAME>
 <ICVBUSES>3</ICVBUSES>
 <INDICAGLS>0</INDICAGLS>
 <ACE_ZIP>0</ACE_ZIP>
 <SUPER_ACE>0</SUPER_ACE>
 <XENONPICKUPS>0</XENONPICKUPS>
 </S_SRC>
 </old>
 </tuple>
 */

@property (nonatomic, copy) NSString *FN;
@property (nonatomic, copy) NSString *LN;
@property (nonatomic, copy) NSString *DSE_NAME;
@property (nonatomic, copy) NSString *ICVBUSES;
@property (nonatomic, copy) NSString *INDICAGLS;
@property (nonatomic, copy) NSString *ACE_ZIP;
@property (nonatomic, copy) NSString *SUPER_ACE;
@property (nonatomic, copy) NSString *XENONPICKUPS;


@end
extern EventExecutiveDashboard_NEEV *eventExecutiveDashboard;
//
//  GlobalVariables.h
//  SFA
//
//  Created by Admin on 19/02/14.
//  Copyright (c) 2014 ttl. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSMutableArray *GlobalVariablesArray_;


@interface GlobalVariables : NSObject
{
    NSString *g_Artifact;
    NSString *g_CurentDate;
    NSString *g_UserName;
    
}

+(id)sharedmanager;
@property(nonatomic,strong) NSString *g_Artifact;
@property(nonatomic,strong) NSString *g_CurrentDate;
@property(nonatomic,strong) NSString *g_UserName;


@end

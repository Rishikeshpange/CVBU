//
//  SingletonClass.m
//  CRM_APP
//
//  Created by Admin on 03/02/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import "SingletonClass.h"

@implementation SingletonClass
@synthesize GetSalesPipeLineDashboard_DSMPLAll_singleTonArr,GetSalesPipeLineDashboard_DSEPLArrSingleton;
static SingletonClass*  _sharedobject=nil;

+(SingletonClass *)sharedobject

{
    @synchronized([SingletonClass class])
    {
        if (!_sharedobject)
            _sharedobject=[[self alloc] init];
        
        return _sharedobject;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([SingletonClass class])
    {
        NSAssert(_sharedobject == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedobject = [super alloc];
        return _sharedobject;
    }
    
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        
    }
    
    return self;
}
@end

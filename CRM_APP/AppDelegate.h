//
//  AppDelegate.h
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic) BOOL authenticated;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@property(nonatomic, readwrite)  NSInteger *optyrow;
@property(nonatomic,retain) NSString *opty_idDetailPage;

//-(void)callArtifactRequest;
//-(void)callDateRequest;
@property(nonatomic,retain) NSString *URL;
@property(nonatomic,retain) NSString *artifact;
@property(nonatomic,retain) NSMutableString *loginX;

@property(nonatomic,retain)NSArray *loginUD;
@property long *tableCounter;
@property int flagget;
@property(nonatomic,readwrite)int flagcheck;

@property(nonatomic, strong) NSMutableArray *districtArray;
@property(nonatomic, strong) NSMutableArray *CitiesArray;
@property(nonatomic, strong) NSMutableArray *TalukaArray;

@property(nonatomic, strong) IBOutlet NSMutableArray *OppurtunityList;
@property(nonatomic, readwrite)  NSInteger *Manageoptyrow;

@property(nonatomic,retain) NSString *fromCreatequote;//create quote ->update opty

@property(nonatomic,retain) NSString *fromManageOptyview;
@property(nonatomic,retain) NSString *fromSearchOptyview;


@property(nonatomic, strong) NSMutableArray *listofProduct_analytics;
@property(nonatomic,retain) NSString *flagappname;
@property(nonatomic,retain) NSString *hidepopoverstring;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,retain) NSString *PPL;
@property (strong, nonatomic) IBOutlet NSString *PLUPDATED;

@property (strong, nonatomic) IBOutlet NSString *optyflow;

@property(nonatomic,retain ) NSString *LOBPPLIsselected;

@property(nonatomic, strong) NSMutableArray *geoArray;
@property(nonatomic, strong) NSMutableArray *FinanceArray;
@property(nonatomic, strong) NSMutableArray *StateArray;



//-(void)callArtifactRequest;
//-(void)callDateRequest;
-(void)callArtifactRequest;



@end

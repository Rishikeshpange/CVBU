//
//  LoginViewController.h
//  test
//
//  Created by admin on 02/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "UserDetails_Var.h"
#import "GlobalVariables.h"
#import "LTransitionImageView.h"
@interface LoginViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSXMLParserDelegate>
{
    AppDelegate *appdelegate;
    UserDetails_Var *userDetailsVal_;
    NSMutableArray *userDetailsArray;
    GlobalVariables *globalVariables_;
    LTransitionImageView *_transitionImageView;


}

- (IBAction)loginScreeb:(id)sender;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *LoginButton;

@property(strong,nonatomic) IBOutlet NSMutableData *webData;

@property(strong,nonatomic) IBOutlet NSMutableString *AssertionArtifact;

@property(strong,nonatomic) IBOutlet NSString *NewUrl;

@property(strong,nonatomic) IBOutlet NSMutableString *CurrentDate;

@property(strong,nonatomic) NSXMLParser *parser;

@property (nonatomic,readwrite) int flag;

- (IBAction)btnRemember:(id)sender;


@end

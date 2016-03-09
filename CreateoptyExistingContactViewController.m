//
//  CreateoptyExistingContactViewController.m
//  testapp
//
//  Created by Admin on 05/03/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "CreateoptyExistingContactViewController.h"
#import "Contacts_table.h"
#import "OpportunityTableViewCell.h"


@interface CreateoptyExistingContactViewController ()

@end

@implementation CreateoptyExistingContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableview1.separatorColor = [UIColor clearColor];
    self.tableview2.separatorColor =[UIColor clearColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     if(tableView == self.tableview1)
     {
    return 12;
     }
     else{
         
       return 5;
     }
         
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
  
    
    if(tableView == self.tableview1)
    {
        static NSString *MyIdentifier = @"TableIdentifier1";
        
         Contacts_table *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
         [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius=4;
        
        [self.tableview1 setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 15)];
        if (cell == nil)
        {
             cell = [[Contacts_table alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
    
      
        cell.lbl_fullname.text=@"Amar";
        cell.lbl_lastname.text=@"Patil";
        cell.lbl_customerno.text=@"9989787865";
        
   
        
        
        return cell;
    }
    else{
        static NSString *MyIdentifier = @"TableIdentifier2";
        
        OpportunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor];
        [cell.contentView.layer setBorderWidth:1.0f];
        cell.contentView.layer.cornerRadius=4;
  [self.tableview2 setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 15)];
        
        if (cell == nil)
        {
            cell = [[OpportunityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
     
        cell.lbl_optyfirstname.text=@"Nikhil";
        cell.lbl_optylastname.text=@"Sharma";
        cell.lbl_mobilenumber.text=@"9978565676";
        cell.lbl_optyppl.text=@"ICV Buses";
        cell.lbl_salesstage.text=@"C0 Prospecting";
        cell.lbl_optycreateddate.text=@"23/12/2015";
    
        return cell;
        
        
    }
  
}





@end

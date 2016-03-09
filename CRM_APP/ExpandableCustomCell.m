//
//  ExpandableCustomCell.m
//  dashboard
//
//  Created by administrator on 1/17/16.
//  Copyright © 2016 administrator. All rights reserved.
//

#import "ExpandableCustomCell.h"
#import "newTableViewCell.h"
#import "SingletonClass.h"
#import "GetSalesPipeLineDashboard_DSM.h"


@implementation ExpandableCustomCell

@synthesize subtitleAlis,subtitleAlis1,subtitleAlis2,subtitleAlis3,subtitleAlis4,title,textLable;
@synthesize  InnerExpandableTblView;
- (void)awakeFromNib {
    // Initialization code
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ReloadDataFunction:)
                                                 name:@"refresh"
                                               object:nil];
     selectedIndex = -1;

}
- (void)ReloadDataFunction:(NSNotification*)notification
{
    [self.InnerExpandableTblView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number o
    //return 8;
  return   [[SingletonClass sharedobject].GetPL_PPLDSM_SingletonArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewTableViewCell";
    
    newTableViewCell *cell = (newTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"newTableViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }if([[SingletonClass sharedobject].GetPL_PPLDSM_SingletonArr count]>0)
    {
        cell.LLB1.text = [[SingletonClass sharedobject].GetPL_PPLDSM_SingletonArr objectAtIndex:indexPath.row];

    }
    if([[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSMPLAll_singleTonArr count]>indexPath.row)
    {
   //NSString *str = [[[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSMPLAll_singleTonArr objectAtIndex:indexPath.row];
                    salesPipelineDashboardDSM = nil;
                    salesPipelineDashboardDSM = [[GetSalesPipeLineDashboard_DSM alloc]init];
                    salesPipelineDashboardDSM = [[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSMPLAll_singleTonArr objectAtIndex:indexPath.row];
        cell.saleStage1.text = [salesPipelineDashboardDSM alias];
        cell.saleStage2.text =  [salesPipelineDashboardDSM alias1];
        
        cell.saleStage3.text =  [salesPipelineDashboardDSM alias2];
        cell.saleStage4.text =[salesPipelineDashboardDSM alias3];
        cell.saleStage5.text = [salesPipelineDashboardDSM alias4];
    }
    
    
    if ([[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSEPLArrSingleton count]>indexPath.row)
         

     {
         
         salesPipelineDashboardDSM = nil;
         salesPipelineDashboardDSM = [[GetSalesPipeLineDashboard_DSM alloc]init];
         salesPipelineDashboardDSM = [[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSEPLArrSingleton objectAtIndex:indexPath.row];


         
     cell.saleStage1.text  = [salesPipelineDashboardDSM  alias];
     cell.saleStage2.text  = [salesPipelineDashboardDSM  alias1];
     cell.saleStage3.text  = [salesPipelineDashboardDSM  alias2];
     cell.saleStage4.text  = [salesPipelineDashboardDSM  alias3];
     cell.saleStage5.text  = [salesPipelineDashboardDSM  alias4];
     
     
     
     }
    
    return cell;
}
#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(selectedIndex==indexPath.row )
    {
        return 100;
        
    }
    else
    {
        return 34;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(selectedIndex==indexPath.row )
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    //user tabs diff row
    if(selectedIndex!= -1)
        
    {
        NSIndexPath *prePath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        selectedIndex = (int)indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:prePath, nil] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    //user select new row with none expandable
    selectedIndex = (int)indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

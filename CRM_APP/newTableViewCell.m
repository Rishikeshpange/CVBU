//
//  newTableViewCell.m
//  dashboardDemo
//
//  Created by Admin on 03/02/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import "newTableViewCell.h"
#import "insideNewTableViewCell.h"

@implementation newTableViewCell
@synthesize saleStage1,saleStage2,saleStage3,saleStage4,saleStage5;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InsideNewTableViewCellObj";
    
    insideNewTableViewCell *insideNewTableViewCellObj = (insideNewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (insideNewTableViewCellObj == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"insideNewTableViewCell" owner:self options:nil];
        
        insideNewTableViewCellObj = [nib objectAtIndex:0];
    }
    insideNewTableViewCellObj.Insidetitle.text = @"its cool";
    return insideNewTableViewCellObj;
}
#pragma mark - Table view delegate

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//
//        return 34;
//
//}

@end

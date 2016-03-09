//
//  PPLViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/12/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "PPLViewController.h"
#import "PPLcell.h"
#import "createoptydata.h"
#import "CreateOptyViewController.h"


@interface PPLViewController ()
{
    NSMutableArray *Buspplimagesarray,*Buspplnamearray,*HCVCargopplnamearray,*IMCVTruckpplnamearray,*LCVpplnamearray,*MHCVpplnamearray,*PCVVenturepplnamearray,*pickupspplnamearray,*SCVcargopplnamearray,*SCVPasspplnamearray,*scpasspplnamearray,*_analyticsMonth,*Scvcargopplimagesarray,*HCVCargopplimagesarray,*IMCVTruckpplimagesarray,*LCVpplimagesarray,*PCVVenturepplimagesarray,*MHCVpplimagesarray,*pickupspplimagesarray,*scpasspplimagesarray;
    NSArray *recipeImages;
}
@end

@implementation PPLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"LOB name%@",optyData.LOB);
    
    _pplvalue.text=optyData.LOB;
    
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    NSLog(@"Samlp Art Master: %@",appdelegate.artifact);
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
    
    
    appdelegate.LOBPPLIsselected=@"NO";
    
    
    
    
    _analyticsMonth=[[NSMutableArray alloc]initWithObjects:@"January",@"October",@"November",@"December", nil];
    
    
    Buspplimagesarray =[[NSMutableArray alloc]initWithObjects:@"Buses_PPL_1.png",@"Buses_PPL_2.png",@"Buses_PPL_3.png", nil];
    Buspplnamearray =[[NSMutableArray alloc]initWithObjects:@"ICV Buses",@"LCV Buses",@"M&HCV Buses",nil];
    
    
    
    HCVCargopplnamearray =[[NSMutableArray alloc]initWithObjects:@"MAV",@"MAV 25",@"MAV 31"@"MAV 37",@"MPV",@"Tractor Trailers",nil];
    
    HCVCargopplimagesarray =[[NSMutableArray alloc]initWithObjects:@"HCV1.png",@"HCV2.png",@"HCV3.png",@"HCV4.png",@"HCV5.png",@"HCV6.png",nil];
    
    
  
    
    IMCVTruckpplnamearray =[[NSMutableArray alloc]initWithObjects:@"11 Tonne Truck",@"8 Tonne Trucks",@"9 Tonne Trucks"@"ICV Tippers",@"ICV Trucks",@"LPT MCV",@"SE MCV",nil];
    
    
    IMCVTruckpplimagesarray =[[NSMutableArray alloc]initWithObjects:@"IMCV1.png",@"IMCV2.png",@"IMCV3.png",@"IMCV4.png",@"IMCV5.png",@"IMCV6.png",@"IMCV7.png",nil];
    
   
    
    LCVpplnamearray =[[NSMutableArray alloc]initWithObjects:@"4 Tonne Pickup",@"4 Tonne Trucks",@"7 Tonne Trucks",@"LCV Tippers",nil];
    LCVpplimagesarray =[[NSMutableArray alloc]initWithObjects:@"LCV1.png",@"LCV2.png",@"LCV3.png",@"LCV4.png",nil];
    
    
    
    PCVVenturepplnamearray  =[[NSMutableArray alloc]initWithObjects:@"Venture", nil];
    PCVVenturepplimagesarray  =[[NSMutableArray alloc]initWithObjects:@"PCV-Venture.png", nil];
    
     MHCVpplnamearray =[[NSMutableArray alloc]initWithObjects:@"MAV Tippers",@"MCV Tippers",nil];
    MHCVpplimagesarray =[[NSMutableArray alloc]initWithObjects:@"MHCV1.png",@"MHCV2.png",nil];
    
    
   
    
    pickupspplnamearray=[[NSMutableArray alloc]initWithObjects:@"Xenon Pickups", nil];
     pickupspplimagesarray=[[NSMutableArray alloc]initWithObjects:@"Xenon.png", nil];
    
    
    
    
    SCVcargopplnamearray=[[NSMutableArray alloc]initWithObjects:@"Ace Mega",@"Ace_Zip",@"Super_Ace",@"Tata Ace", nil];
    
    Scvcargopplimagesarray=[[NSMutableArray alloc]initWithObjects:@"SCV1.png",@"SCV2.png",@"SCV3.png",@"SCV4.png", nil];
    
    
    scpasspplnamearray=[[NSMutableArray alloc]initWithObjects:@"Winger",@"Winger_Platinum", nil];
    
      scpasspplimagesarray=[[NSMutableArray alloc]initWithObjects:@"ScPass1.png",@"ScPass2.png", nil];
    
    
    
    
    
   
    
        SCVPasspplnamearray=[[NSMutableArray alloc]initWithObjects:@"Magic",@"SCV Pass-Magic IRIS",nil];
    
    
}

- (void)didReceiveMemoryWarning {
    
    
    [super didReceiveMemoryWarning];
    
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    if ([optyData.LOB isEqualToString:@"Buses"]) {
        return Buspplimagesarray.count;
    }
    else if ([optyData.LOB isEqualToString:@"HCV Cargo"]){
        
        return HCVCargopplimagesarray.count;
    }
    else if ([optyData.LOB isEqualToString:@"I&MCV Trucks"]){
        
        return IMCVTruckpplimagesarray.count;
    }
    else if ([optyData.LOB isEqualToString:@"LCV"]){
        
        return LCVpplimagesarray.count;
    }
    else if ([optyData.LOB isEqualToString:@"PCV - Venture"]){
        
        return PCVVenturepplimagesarray.count;
    }
    else if ([optyData.LOB isEqualToString:@"Pickups"]){
        
        return pickupspplimagesarray.count;
    }
    //SCV Cargo
    else if ([optyData.LOB isEqualToString:@"SCV Cargo"]){
    
         return Scvcargopplimagesarray.count;
    }
    else if ([optyData.LOB isEqualToString:@"ScPass"]){
        
        return scpasspplimagesarray.count;
    }
    else if ([optyData.LOB isEqualToString:@"M&HCV Const"]){
        
        return MHCVpplimagesarray.count;
    }
    
    
    return 0;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    PPLcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if ([optyData.LOB isEqualToString:@"Buses"]) {
        cell.PPLimg.image = [UIImage imageNamed:[Buspplimagesarray objectAtIndex:indexPath.row]];
    }
    else if ([optyData.LOB isEqualToString:@"HCV Cargo"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[HCVCargopplimagesarray objectAtIndex:indexPath.row]];
        
    }
    else if ([optyData.LOB isEqualToString:@"I&MCV Trucks"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[IMCVTruckpplimagesarray objectAtIndex:indexPath.row]];
        
    }
    else if ([optyData.LOB isEqualToString:@"LCV"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[LCVpplimagesarray objectAtIndex:indexPath.row]];
        
    }
    //PCV - Venture
    
    else if ([optyData.LOB isEqualToString:@"PCV - Venture"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[PCVVenturepplimagesarray objectAtIndex:indexPath.row]];
        
    }
    //Pickups
    
    else if ([optyData.LOB isEqualToString:@"Pickups"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[pickupspplimagesarray objectAtIndex:indexPath.row]];
        
    }
    else if ([optyData.LOB isEqualToString:@"SCV Cargo"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[Scvcargopplimagesarray objectAtIndex:indexPath.row]];
        
    }
    else if ([optyData.LOB isEqualToString:@"ScPass"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[scpasspplimagesarray objectAtIndex:indexPath.row]];
        
    }
    
    else if ([optyData.LOB isEqualToString:@"M&HCV Const"])
    {
        
        cell.PPLimg.image = [UIImage imageNamed:[MHCVpplimagesarray objectAtIndex:indexPath.row]];
        
    }
    
    
    
    return cell;
    
    
    
    
}








- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    if ([optyData.LOB isEqualToString:@"Buses"]) {
        
        optyData.PPL = [Buspplnamearray objectAtIndex:(long)indexPath.row];
        
    }
    else if ([optyData.LOB isEqualToString:@"HCV Cargo"])
        
    {
        
        optyData.PPL = [HCVCargopplnamearray objectAtIndex:(long)indexPath.row];
    }
    else if ([optyData.LOB isEqualToString:@"I&MCV Trucks"])
        
    {
        
        optyData.PPL = [IMCVTruckpplnamearray objectAtIndex:(long)indexPath.row];
    }
    else if ([optyData.LOB isEqualToString:@"LCV"])
        
    {
        
        optyData.PPL = [LCVpplnamearray objectAtIndex:(long)indexPath.row];
    }
    
    else if ([optyData.LOB isEqualToString:@"PCV - Venture"])
        
    {
        
        optyData.PPL = [PCVVenturepplnamearray objectAtIndex:(long)indexPath.row];
    }
    else if ([optyData.LOB isEqualToString:@"Pickups"])
        
    {
        
        optyData.PPL = [pickupspplnamearray objectAtIndex:(long)indexPath.row];
    }
    
    else if ([optyData.LOB isEqualToString:@"SCV Cargo"])
        
    {
        
        optyData.PPL = [SCVcargopplnamearray objectAtIndex:(long)indexPath.row];
    }
    
    else if ([optyData.LOB isEqualToString:@"ScPass"])
        
    {
        
        optyData.PPL = [scpasspplnamearray objectAtIndex:(long)indexPath.row];
    }
    else if ([optyData.LOB isEqualToString:@"M&HCV Const"])
        
    {
        
        optyData.PPL = [MHCVpplnamearray objectAtIndex:(long)indexPath.row];
    }
    
    
    
    NSLog(@"selected ppl %@%@",optyData.PPL,optyData.LOB);
    
    appdelegate.LOBPPLIsselected=@"YES";
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
}






@end


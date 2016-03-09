//
//  RecipeCollectionViewController.m
//  RecipePhoto
//
//  Created by Simon on 13/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RecipeCollectionViewController.h"
#import "CreateOptyViewController.h"


@interface RecipeCollectionViewController () {
    NSArray *recipeImages,*recipeImages1;
    NSString *Optystatus;
    UITextField *textField;
}

@end

@implementation RecipeCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    Optystatus=@"LOB";
    
        recipeImages1 = [NSArray arrayWithObjects:@"optyID.png", @"cellno.png", nil];
        
        
        
   
    

    recipeImages = [NSArray arrayWithObjects:@"optyID.png", @"cellno.png", @"calender.png", @"salesstage.png", @"address.png",  nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
     if ([Optystatus isEqualToString:@"LOB"]) {
    return recipeImages.count;
         
     }
     else{
     
     return recipeImages1.count;
     }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    
    if ([Optystatus isEqualToString:@"LOB"]) {
      
        
        recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    }
    else{
    recipeImageView.image = [UIImage imageNamed:[recipeImages1 objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
 NSLog(@"Row index : %ld",(long)indexPath.row);
    
  if ([Optystatus isEqualToString:@"LOB"]) {
      
      Optystatus=@"PPL";
      
      
      [collectionView reloadData];
      
      
  }
  else{
  
  
      NSLog(@"done ");
      
      
[self dismissViewControllerAnimated:YES completion:nil];
      NSLog(@"dismiss");
      
 
    
      
  
  }



}





@end

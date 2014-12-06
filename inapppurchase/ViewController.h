//
//  ViewController.h
//  inapppurchase
//
//  Created by zer0 on 11/29/14.
//  Copyright (c) 2014 afiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong,nonatomic) NSArray *products;
@property (strong,nonatomic) NSUserDefaults *defaults;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *adsView;
-(IBAction)removeAds:(id)sender;
-(void)Purchase;

@end


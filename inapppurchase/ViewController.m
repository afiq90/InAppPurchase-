//
//  ViewController.m
//  inapppurchase
//
//  Created by zer0 on 11/29/14.
//  Copyright (c) 2014 afiq. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface ViewController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@end

@implementation ViewController
@synthesize titleLabel,defaults,adsView,products;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // SKPaymentQueue
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isPro = [defaults boolForKey:@"isPro"];
    
    if (!isPro) {
        // Show the ads
        [self fetchProducts];
        self.buyButton.enabled = YES;

    } else {
        // Hide ads
        adsView.alpha = 0.0;
        self.buyButton.enabled = NO;
    }
}

-(void)Purchase {
    self.titleLabel.text = @"The item has been purchased.";
}

-(void)fetchProducts {
    NSSet *set = [NSSet setWithArray:@[@"com.afiq.inapppurchase.iAP2"]];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    
    [request start];
}

-(void)Buy:(SKProduct *)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];

}

- (IBAction)removeAds:(id)sender {
    
    SKProduct *prod = [products objectAtIndex:0];
    [self Buy:prod];
}

#pragma mark - SKProductsRequestDelegate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {

    products = response.products;
    NSLog(@"product is available");
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Error ; %@", error);
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {

    for (SKPaymentTransaction *tx in transactions) {
        switch (tx.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [[SKPaymentQueue defaultQueue] finishTransaction:tx];
                adsView.alpha = 0.0;
                [defaults setBool:YES forKey:@"isPro"];
                self.buyButton.enabled = NO;
                break;
                
            case SKPaymentTransactionStateFailed:
                [[SKPaymentQueue defaultQueue] finishTransaction:tx];
                NSLog(@"Error : %@", tx.error);
                break;
                
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue] finishTransaction:tx];
                break;
                
            default:
                break;
        }
    }
    
}





@end

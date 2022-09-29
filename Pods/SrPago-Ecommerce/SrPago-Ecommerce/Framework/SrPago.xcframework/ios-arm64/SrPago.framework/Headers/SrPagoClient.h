//
//  SrPagoClient.h
//  SrPago
//
//  Created by Armando on 10/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPCard.h"

@class SPTokenService;

@interface SrPago : NSObject
{
    
}
/**
 for set the publishable key
 */
@property (nonatomic, strong)NSString *publishableKey;
/**
 for set the environment. FALSE for SANDBOX, TRUE for PRODUCTION
 */
@property (nonatomic) bool  liveMode;
/**
 Token service
 */
@property (nonatomic, retain) SPTokenService* token;

/**
Returns Singleton of SPTokenService Class
*/
+ (id)sharedInstance;
 

@end

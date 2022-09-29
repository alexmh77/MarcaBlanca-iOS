//
//  SPClientService.h
//  SrPago
//
//  Created by Armando on 10/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPCard.h"
#import "SPService.h"
#import "SPToken.h"


@interface SPTokenService : SPService


/**
 Request a token for a given card
 @param card SPCard model with the info granted by user
 */
- (void)createTokenWithCard:(SPCard *)card
                       onSuccess:(void (^) (SPToken* token))success onFail:(SPOnError)error;
 

@end

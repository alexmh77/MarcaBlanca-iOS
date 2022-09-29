//
//  SPUserAgentService.h
//  SrPago
//
//  Created by Armando on 19/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPUserAgentModel.h"

@interface SPUserAgentService : NSObject

+ (SPUserAgentService *)sharedInstance;


-(NSString *)getUserAgentJSONString;

@end

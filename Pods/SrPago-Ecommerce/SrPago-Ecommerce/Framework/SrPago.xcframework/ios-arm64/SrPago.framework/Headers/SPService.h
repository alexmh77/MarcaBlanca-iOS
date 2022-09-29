//
//  SPService.h
//  SrPago
//
//  Created by Armando on 10/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPError.h"
#import "SPUserAgentService.h"
#import "SPUserAgentModel.h"

typedef void (^SPOnError)(SPError* error);

@interface SPService : NSObject

-(NSURL *)getURLWithServicePath:(NSString *)servicePath;

-(NSString *)getURLStringWithServicePath:(NSString *)servicePath;



@end

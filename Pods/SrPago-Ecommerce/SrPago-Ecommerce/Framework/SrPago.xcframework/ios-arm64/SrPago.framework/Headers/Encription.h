//
//  Encription.h
//  SrPago
//
//  Created by Armando on 09/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCryptedParameters.h"

@interface Encription : NSObject

+ (Encription *)sharedInstance;

-(NSDictionary *)cryptedParametersWithString:(NSString *)parametersJson;

@end

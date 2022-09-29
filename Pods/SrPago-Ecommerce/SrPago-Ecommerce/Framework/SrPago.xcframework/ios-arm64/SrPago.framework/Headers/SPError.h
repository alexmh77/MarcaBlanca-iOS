//
//  SPError.h
//  SrPago
//
//  Created by Armando on 16/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPError : NSObject

@property (nonatomic)NSString * message;
@property (nonatomic)NSString * descriptionText;
@property (nonatomic)NSString * code;

+(SPError *)errorForResponseDataWithDictionary:(NSDictionary *)errorDictionary;

+(SPError *)errorForServerFailureWithDictionary:(NSDictionary *)errorDictionary;

@end

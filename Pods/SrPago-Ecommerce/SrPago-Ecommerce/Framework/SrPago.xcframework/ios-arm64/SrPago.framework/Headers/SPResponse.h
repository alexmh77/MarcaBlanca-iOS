//
//  SPResponse.h
//  SrPagoSDK
//
//  Created by Alex on 01/10/15.
//  Copyright © 2015 Pixzelle. All rights reserved.
//

#import "SPBase.h"

@interface SPResponse : SPBase

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSMutableDictionary *errorDetail;
@property (copy, nonatomic) NSString *errorCode;
@property (copy, nonatomic) NSString *message;
@property BOOL status;

@end
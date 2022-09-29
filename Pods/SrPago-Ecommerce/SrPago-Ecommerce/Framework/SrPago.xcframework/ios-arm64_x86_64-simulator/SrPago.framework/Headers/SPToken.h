//
//  SPToken.h
//  SrPago
//
//  Created by Armando on 16/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPToken : NSObject

//the token string of the sended card
@property (strong, nonatomic)NSString *token;
@property (strong, nonatomic)NSString *bankName;
@property (strong, nonatomic)NSNumber *points;

@end

//
//  SPBase.h
//  SrPagoSDK
//
//  Created by Alex on 01/10/15.
//  Copyright © 2015 Pixzelle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPBase : NSObject

@property int identifier;
@property (strong, nonatomic) NSString *guid;
@property (strong, nonatomic) NSString *name;

@end
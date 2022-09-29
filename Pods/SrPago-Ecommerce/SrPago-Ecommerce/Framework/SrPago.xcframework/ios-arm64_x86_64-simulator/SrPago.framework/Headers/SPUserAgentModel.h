//
//  SPUserAgentModel.h
//  SrPago
//
//  Created by Armando on 19/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPUserAgentModel : NSObject

@property (nonatomic)NSString *language;
@property (nonatomic)NSString *version;
@property (nonatomic)NSString *name;
@property (nonatomic)NSString *SDKVersion;
@property (nonatomic)NSString *OSVersion;
@property (nonatomic)NSString *OSName;
@property (nonatomic)NSString *DeviceModel;
@property (nonatomic)NSString *APIVersion;
@property (nonatomic)NSString *latitude;
@property (nonatomic)NSString *longitude;
@property (nonatomic)NSString *device_id;



@end

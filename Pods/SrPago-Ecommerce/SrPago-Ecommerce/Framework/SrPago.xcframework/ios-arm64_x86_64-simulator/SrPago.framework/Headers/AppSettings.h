//
//  AppSettings.h
//  SrPago Dashboard
//
//  Created by Armando on 26/04/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettings : NSObject

@property (nonatomic, strong)NSDictionary *plistDict;

+ (id)sharedInstance;

-(id)getValueForKey:(NSString *)key isLiveMode:(BOOL)isLiveMode;

@end

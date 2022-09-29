//
//  SPCard.h
//  SrPago
//
//  Created by Armando on 10/05/17.
//  Copyright © 2017 Sr. Pago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCard : NSObject

typedef NS_ENUM(NSUInteger, SP_CARD_VALIDATION_STATUS) {
    SP_CARD_VALIDATION_INVALID_NUMBER,
    SP_CARD_VALIDATION_INVALID_CVV,
    SP_CARD_VALIDATION_INVALID_EXPIRATION,
    SP_CARD_VALIDATION_INVALID_NAME,
    SP_CARD_VALIDATION_VALID_CARD
};

typedef NS_ENUM(NSUInteger, SP_CARD_TYPE) {
    SP_CARD_TYPE_AMEX_CARD,
    SP_CARD_TYPE_VISA_CARD,
    SP_CARD_TYPE_MAST_CARD,
    SP_CARD_TYPE_UNKNOWN_CARD,
};

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *number;
@property (nonatomic, strong)NSString *expMonth;
@property (nonatomic, strong)NSString *expYear;
@property (nonatomic, strong)NSString *cvv;


/**
 Returns a string ready to use for the token request web service
 */
-(NSString *)cardJSONForRequest;
/**
 Applies all the validations to the card object and returns a status
 */
-(SP_CARD_VALIDATION_STATUS)validateCard;



/**
 Returns a BOOL indicating if the length is right and is a valid Luhn number
 */
+(BOOL)isValidCardNumber:(NSString *)cardNumber;
/**
 Applies modulus 10 algorithm to the card number and returns TRUE if is valid
 */
+(BOOL)isValidLuhnNumber:(NSString *)cardNumber;
/**
 Returns TRUE if card number has 15 or 16 digits
 */
+(BOOL)isValidCardLength:(NSString *)cardNumber;
/**
 Returns TRUE if CVV has 3 or 4 digits
 */
+(BOOL)isValidCVV:(NSString *)cvv;
/**
 Returns TRUE if cardholder name has more than 3 characters and less than 27, excluding spaces.
 */
+(BOOL)isValidCardHolderName:(NSString *)cardHolderName;
/**
 Returns TRUE if the date is valid and it isn't already expired.
 */
+(BOOL)isValidExpirationWithYear:(NSString *)year month:(NSString *)month;
/**
 Returns the bank identifier (VISA, MASTERCARD, AMEX) according the two first digits of the card number.
 */
+(SP_CARD_TYPE)getPossibleCardType:(NSString *)cardNumber;

@end

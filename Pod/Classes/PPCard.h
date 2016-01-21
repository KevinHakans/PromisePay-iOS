//
//  PPCard.h
//  PromisePay
//
//  Created by Kevin Hakans on 01/11/16.
//  Copyright © 2016 PromisePay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPCard : NSObject

/// A convenience initializer for creating a card account creat request.
- (instancetype)initWithNumber:(NSString *)number
                      fullName:(NSString *)fullName
                   expiryMonth:(NSString *)expiryMonth
                    expiryYear:(NSString *)expiryYear
                           cvv:(nullable NSString *)cvv;

- (instancetype)initWithParameters:(NSDictionary *)parameters NS_DESIGNATED_INITIALIZER;

/// @name Parameters
- (NSDictionary *)parameters;



/// The card number
@property (nonatomic, nullable, copy) NSString *number;
/// The name on card
@property (nonatomic, nullable, copy) NSString *fullName;
/// The expiration month as a one or two-digit number on the Gregorian calendar
@property (nonatomic, nullable, copy) NSString *expiryMonth;
/// The expiration year as a two or four-digit number on the Gregorian calendar
@property (nonatomic, nullable, copy) NSString *expiryYear;
/// The card CVV
@property (nonatomic, nullable, copy) NSString *cvv;

@end

NS_ASSUME_NONNULL_END
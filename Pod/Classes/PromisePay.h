//
//  PromisePay.h
//  PromisePay
//
//  Created by Kevin Hakans on 01/11/16.
//  Copyright © 2016 PromisePay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface PromisePay : NSObject

- (nullable instancetype)init __attribute__((unavailable("Please use initWithEnvironment:publicKey: instead.")));

/**
 * This method will encrypt any data passed to it using the public key provided in the configuration.
 * @constructor
 * @param {NSString} environment - Environment of package ("prelive" or "prod").
 * @param {NSString} publicKey - Public key provided by PromisePay.
 */
- (instancetype)initWithEnvironment:(NSString *)environment publicKey:(NSString *)publicKey NS_DESIGNATED_INITIALIZER;

/**
 * This method will encrypt the card account information using the marketplace public key. It will then create the card account in PromisePay.
 * @constructor
 * @param {NSString} cardToken - A one-time use token that lasts for 20 minutes. Generate using https://promisepay-api.readme.io/docs/generate-a-card-token. It is assigned to a user within the marketplace to authorize the creation of a card account. It is NOT the token for a credit account that is generated, that is the 'Card Account ID'.
 * @param {NSString} cardData - Full card information (eg. { full_name: "Bobby Buyer", number: "4111111111111111", expiry_month: "02", expiry_year: "2018", cvv: "123" })
 * @param {string} successFunction - Custom function to call back once card creation is a success.
 * @param {string} failFunction - Custom function to call back once card creation is a failure.
 */
- (void)createCardAccount:(NSString *)cardToken card:(PPCard *)card callBack:(void (^)(id result, NSError *error))callback;
@end

NS_ASSUME_NONNULL_END
//
//  PPCard.m
//  PromisePay
//
//  Created by Kevin Hakans on 01/11/16.
//  Copyright © 2016 PromisePay. All rights reserved.
//

#import "PPCard.h"

@interface PPCard ()
@property (nonatomic, strong) NSMutableDictionary *mutableParameters;
@end

@implementation PPCard

- (instancetype)init {
    return [self initWithParameters:@{}];
}

- (nonnull instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super init]) {
        _mutableParameters = [parameters mutableCopy];
    }
    return self;
}

- (instancetype)initWithNumber:(NSString *)number
                      fullName:(NSString *)fullName
                   expiryMonth:(NSString *)expiryMonth
                    expiryYear:(NSString *)expiryYear
                           cvv:(nullable NSString *)cvv
{
    if (self = [self initWithParameters:@{}]) {
        _number = number;
        _fullName = fullName;
        _expiryMonth = expiryMonth;
        _expiryYear = expiryYear;
        _cvv = cvv;
    }
    return self;
}

#pragma mark -

- (NSDictionary *)parameters {
    NSMutableDictionary *p = [self.mutableParameters mutableCopy];
    if (self.number) {
        p[@"number"] = self.number;
    }
    if (self.fullName) {
        p[@"full_name"] = self.fullName;
    }
    if (self.expiryMonth) {
        p[@"expiry_month"] = self.expiryMonth;
    }
    if (self.expiryYear) {
        p[@"expiry_year"] = self.expiryYear;
    }
    if (self.cvv) {
        p[@"cvv"] = self.cvv;
    }
    
    return [p copy];
}

@end

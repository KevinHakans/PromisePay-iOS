//
//  PromisePay.m
//  PromisePay
//
//  Created by Kevin Hakans on 01/11/16.
//  Copyright © 2016 PromisePay. All rights reserved.
//

#import "PromisePay.h"

@interface PromisePay () <NSURLSessionDelegate>

@property (nonatomic, copy) NSString *environment;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, strong) NSString *apiUrl;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation PromisePay

- (instancetype)init {
    return nil;
}

- (instancetype)initWithEnvironment:(NSString *)environment publicKey:(NSString *)publicKey {
    if (self = [super init]) {
        if (publicKey != nil) {
            _publicKey = publicKey;
        }
        _environment = environment;
        if ([_environment isEqualToString:@"dev"]) {
            _apiUrl = @"http://api.localhost.local:3000/";
        }
        else if ([_environment isEqualToString:@"prelive"]) {
            _apiUrl = @"https://test.api.promisepay.com/";
        }
        else if ([_environment isEqualToString:@"prod"]) {
            _apiUrl = @"https://secure.api.promisepay.com/";
        }
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        
        NSOperationQueue *delegateQueue = [[NSOperationQueue alloc] init];
        delegateQueue.name = @"com.promisepay.HTTP";
        delegateQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
        
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:delegateQueue];
    }
    return self;
}

- (void)createCardAccount:(NSString *)cardToken card:(PPCard *)card callBack:(void (^)(id result, NSError *error))callback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@card_accounts?card_token=%@", _apiUrl, cardToken]];
    [self httpRequest:url parameters:card.parameters completion:^(NSDictionary *body, NSHTTPURLResponse *response, NSError *error) {
        callback(body, error);
    }];
}


#pragma mark - Underlying HTTP
- (void)httpRequest:(NSURL *)url parameters:(NSDictionary *)parameters completion:(void(^)(NSDictionary *body, NSHTTPURLResponse *response, NSError *error))completionBlock {
    
    if (!url || [url.absoluteString isEqualToString:@""]) {
        NSMutableDictionary *errorUserInfo = [NSMutableDictionary new];
        if (parameters) errorUserInfo[@"parameters"] = parameters;
        completionBlock(nil, nil, [NSError errorWithDomain:@"" code:-1 userInfo:errorUserInfo]);
        return;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithString:url.absoluteString];
    
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:components.URL];
    
    NSError *jsonSerializationError;
    NSData *bodyData;
    
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        bodyData = [NSJSONSerialization dataWithJSONObject:parameters
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&jsonSerializationError];
    }
    
    if (jsonSerializationError != nil) {
        completionBlock(nil, nil, jsonSerializationError);
        return;
    }
    
    [request setHTTPBody:bodyData];
    headers[@"Content-Type"]  = @"application/json; charset=utf-8";
    [request setAllHTTPHeaderFields:headers];
    
    [request setHTTPMethod:@"POST"];
    
    // Perform the actual request
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse;
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            httpResponse = (NSHTTPURLResponse *)response;
        } else if ([response.URL.scheme isEqualToString:@"data"]) {
            httpResponse = [[NSHTTPURLResponse alloc] initWithURL:response.URL statusCode:200 HTTPVersion:nil headerFields:nil];
        }
        completionBlock([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil], httpResponse, error);
    }];
    [task resume];
}

@end

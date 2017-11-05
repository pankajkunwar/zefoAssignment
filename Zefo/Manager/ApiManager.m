//
//  ApiManager.m
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager

+ (ApiManager *)sharedManager {
    static ApiManager *_sharedRestAPIManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRestAPIManager = [[self alloc] init];
    });
    
    return _sharedRestAPIManager;
}

- (instancetype)init {
    self = [super init];
    if (self){
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}


- (void)imageWithUrl:(NSString *)imageUrl WithCompletionblock:(ApiCompletionBlock)completionHandler {
    
    NSURLSessionTask *task = [_session dataTaskWithURL:[NSURL URLWithString:imageUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil,error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:data];
                completionHandler(image, error);
            });
        }
    }];
    
    [task resume];
}

@end

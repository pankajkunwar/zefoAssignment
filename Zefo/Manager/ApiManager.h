//
//  ApiManager.h
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//API handlers
typedef void (^ApiCompletionBlock)(UIImage *image, NSError *error);

@interface ApiManager : NSObject

@property (strong, nonatomic) NSURLSession *session;

+ (ApiManager *)sharedManager;

// Download Image 
- (void)imageWithUrl:(NSString *)imageUrl WithCompletionblock:(ApiCompletionBlock)completionHandler;

@end

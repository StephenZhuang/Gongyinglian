//
//  IntenetRead.h
//  protobufTest
//
//  Created by lu liu on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceRead : NSObject

@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) id delegate;
@property SEL mselector;


-(void)post:(NSString*)methodname namespace:(NSString*)namespace url:(NSString *)surl params:(NSDictionary*)params;

-(void)stop;

@end

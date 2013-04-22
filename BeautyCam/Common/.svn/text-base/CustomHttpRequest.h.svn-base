//
//  CustomHttpRequest.h
//  EveryDay
//
//  Created by LeeSiHyung on 11. 12. 14..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomHttpRequest: NSObject
{
    NSMutableData *receivedData;
    NSURLResponse *response;
    //NSString *result;
    //id target;
    //SEL selector;
}

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSURLResponse *response;
//@property (nonatomic, assign) NSString *result;
//@property (nonatomic, assign) id target;
//@property (nonatomic, assign) SEL selector;

- (BOOL)requestUrl:(NSString *)url bodyObject:(NSDictionary *)bodyObject;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)setDelegate:(id)aTarget selector:(SEL)aSelector;

- (NSString*)machine;

// 통계
- (void)requestFirstExec;
- (void)requestExec;
- (void)takeCamera;
- (void)getPicture;
- (void)setting;
- (void)about;
- (void)editPicture;
- (void)allMakeUp;
- (void)makeUp;
- (void)filter;
- (void)background;
- (void)requestPicshowFolder;

@end

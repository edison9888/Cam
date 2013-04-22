//
//  CustomHttpRequest.m
//  EveryDay
//
//  Created by LeeSiHyung on 11. 12. 14..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomHttpRequest.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include "Util.h"

#define EXEC_URL @"http://app.mapps.kr/beautycamera/log_exec.php"
/*
 p : 플랫폼
 d : 디바이스아이디
 t : 시작 1 , 종료 0
 e : 최초 실행 여부 최초 실행시 1로 넘겨 주세요
 a : 앱 타입(f 무료, p 유료)
 f : 폴더 갯수
 dt : apns 디바이스 토큰
 -------- 아래 파라미터는 최초 실행시만 넘겨주세요 ----------
 n : 국가 
 v : 버젼
 m : 모델
 c : 통신사
 i : 제조사
 */


#define APP_URL @"http://app.mapps.kr/beautycamera/log_app.php"
/*
 p : 플랫폼
 d : 디바이스아이디
 a : 탭핑 위치
 
 a파라미터 값
 사진 가져오기  => m1
 사진 촬영하기  => m2
 설정   => m3
 ABOUT(버전 정보 등) => m4
 화면 보정  => s1
 전체 화장  => s2
 화장 하기  => s3
 특수 효과  => s4
 배경 화면  => s5
*/


@implementation CustomHttpRequest

@synthesize receivedData;
@synthesize response;
//@synthesize result;
//@synthesize target;
//@synthesize selector;

- (BOOL)requestUrl:(NSString *)url bodyObject:(NSDictionary *)bodyObject
{
    // URL Request 객체 생성
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:5.0f];
    
    // 통신방식 정의 (POST, GET)
    [request setHTTPMethod:@"POST"];
    
    // bodyObject의 객체가 존재할 경우 QueryString형태로 변환
    if(bodyObject)
    {
        // 임시 변수 선언
        NSMutableArray *parts = [NSMutableArray array];
        NSString *part;
        id key;
        id value;
        
        // 값을 하나하나 변환
        for(key in bodyObject)
        {
            value = [bodyObject objectForKey:key];
            part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                    [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [parts addObject:part];
        }
        
        // 값들을 &로 연결하여 Body에 사용
        [request setHTTPBody:[[parts componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // Request를 사용하여 실제 연결을 시도하는 NSURLConnection 인스턴스 생성
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // 정상적으로 연결이 되었다면
    if(connection)
    {
        // 데이터를 전송받을 멤버 변수 초기화
        receivedData = [[NSMutableData alloc] init];
        return YES;
    }
    
    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse
{
    // 데이터를 전송받기 전에 호출되는 메서드, 우선 Response의 헤더만을 먼저 받아 온다.
    //[receivedData setLength:0];
    self.response = aResponse;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 데이터를 전송받는 도중에 호출되는 메서드, 여러번에 나누어 호출될 수 있으므로 appendData를 사용한다.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // 에러가 발생되었을 경우 호출되는 메서드
    NSLog(@"Error: %@", [error localizedDescription]);
    /*
    if(target)
    {
        [target performSelector:selector withObject:@"error"];
    }
    */
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 데이터 전송이 끝났을 때 호출되는 메서드, 전송받은 데이터를 NSString형태로 변환한다.
    /*
    result = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    NSString *decodedResult = [result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    decodedResult = [decodedResult stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
    // 델리게이트가 설정되어있다면 실행한다.
    if(target)
    {
        [target performSelector:selector withObject:decodedResult];
    }
    */
}

- (void)setDelegate:(id)aTarget selector:(SEL)aSelector
{
    // 데이터 수신이 완료된 이후에 호출될 메서드의 정보를 담고 있는 셀렉터 설정
    //self.target = aTarget;
    //self.selector = aSelector;
}

- (void)dealloc
{
    /*
    [receivedData release];
    [response release];
    [result release];
    [super dealloc];
    */
}

#pragma mark -
#pragma mark public

// 첫번쨰 실행
- (void)requestFirstExec {

    NSString *uniqueID = [Util getUniqueID];
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];

    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&t=1&e=1&a=f&n=korea&v=%@&p=iphone&av=%@", EXEC_URL, uniqueID, osVersion, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];
}

- (void)requestExec {

    NSString *uniqueID = [Util getUniqueID];
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&t=1&e=0&a=f&n=korea&v=%@&p=iphone&av=%@", EXEC_URL, uniqueID, osVersion, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];
}

- (void)takeCamera {
    
    NSString *uniqueID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=m2&p=iphone&av=%@", APP_URL, uniqueID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];
    
}

- (void)getPicture {

    NSString *uniqueID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=m1&p=iphone&av=%@", APP_URL, uniqueID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];

}

- (void)setting {
 

    NSString *uniqueID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=m3&p=iphone&av=%@", APP_URL, uniqueID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];
    
}

- (void)about {
    

    NSString *uniqueID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=m4&p=iphone&av=%@", APP_URL, uniqueID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];

}

- (void)editPicture {
    

    NSString *uniqueID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=s1&p=iphone&av=%@", APP_URL, uniqueID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];

}

- (void)allMakeUp {
    

    NSString *uniqueID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=s2&p=iphone&av=%@", APP_URL, uniqueID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];

    
}

- (void)makeUp {
    

    NSString *uniqueID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=s3&p=iphone&av=%@", APP_URL, uniqueID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];

}

- (void)filter {
    

    NSString *deviceID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=s4&p=iphone&av=%@", APP_URL, deviceID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];

    
}

- (void)background {
    

    NSString *deviceID = [Util getUniqueID];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&a=s5&p=iphone&av=%@", APP_URL, deviceID, appVersion];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];

}

/*
- (void)requestPicshowFolder {

#ifndef DEBUG
    NSString *deviceID = [[UIDevice currentDevice] uniqueIdentifier];
    
    SQLiteDataAccess* trans = [DataAccessObject database];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT FOLDERINDEX FROM IMAGEFOLDER"];
    NSArray *folderInfoArray =  [trans executeSql:sqlQuery];
    NSInteger folderCnt = [folderInfoArray count];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@?d=%@&t=f&c=%d", PICSHOW_FOLDER_URL, deviceID, folderCnt];
    [self requestUrl:url bodyObject:nil];
    NSLog(@"requestUrl : %@", url);
    //[url release];
#endif
}
*/

@end

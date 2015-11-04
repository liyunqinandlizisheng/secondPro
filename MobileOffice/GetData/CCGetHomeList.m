//
//  CCGetHomeList.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CCGetHomeList.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "CCHomeListData.h"
#import "Const.h"

@implementation CCGetHomeList

@synthesize m_NetData;
@synthesize m_UrlConnection;
@synthesize delegate;
@synthesize m_ArrHomeList;
@synthesize m_bIsExistData;

- (void)getHomeList:(NSString *)homeUrl
{
    NSLog(@"home = %@", homeUrl);
    NSString *strUrl = [homeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:30.0];
    if (!request)
    {
        if (delegate)
        {
            [delegate returnHome:NO andArrHomeList:nil];
        }
        
        return;
    }
    
//    [request setHTTPMethod:@"POST"];
//    
//    [request addValue:[NoteItem objectForKey:@"JSESSIONID"] forHTTPHeaderField:@"JSESSIONID"];
//    
//    NSString *body=[NSString stringWithFormat:@"method=%@&mobile=%@&verfiCodeType=%@&verificationCode=%@",[NoteItem objectForKey:@"method"],[NoteItem objectForKey:@"mobile"],[NoteItem objectForKey:@"verfiCodeType"],[NoteItem objectForKey:@"verificationCode"]];
//    
//    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *strName = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_NAME_KEY];
    NSString *strValue = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_VALUE_KEY];
    NSString *strVersion = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_VERSION_KEY];
    NSString *strPath = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_PATH_KEY];
    NSString *strDomain = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_DOMAIN_KEY];
    //NSString *strExpiresdate = [[NSUserDefaults standardUserDefaults] objectForKey:EXPIRESDATE_KEY];
    //NSString *strSessionOnly = [[NSUserDefaults standardUserDefaults] objectForKey:SESSIONONLY_KEY];
    NSString *strSecure = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_SECURE_KEY];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:strName forKey:NSHTTPCookieName];
    [cookieProperties setObject:strValue forKey:NSHTTPCookieValue];
    [cookieProperties setObject:strVersion forKey:NSHTTPCookieVersion];
    [cookieProperties setObject:strPath forKey:NSHTTPCookiePath];
    [cookieProperties setObject:strDomain forKey:NSHTTPCookieDomain];
    //[cookieProperties setObject:strExpiresdate forKey:NSHTTPCookieExpires];
    [cookieProperties setObject:strSecure forKey:NSHTTPCookieSecure];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    m_UrlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self];
    
    m_NetData = [[NSMutableData alloc] initWithLength:0];
    
    m_ArrHomeList = [[NSMutableArray alloc] initWithCapacity:0];
}


#pragma mark -
#pragma mark Private Class Function
- (BOOL)check404Error
{
    NSString *strData = [NSString stringWithFormat:@"%s", [m_NetData bytes]];
    NSRange stuRange = [strData rangeOfString:@"404 Not Found"];
    if(strData && stuRange.location != NSNotFound)
    {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark NSURLConnectionDelegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSArray *trustedHosts = [NSArray arrayWithObjects:challenge.protectionSpace.host, nil];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.m_NetData = nil;
    m_NetData = [[NSMutableData alloc] initWithCapacity:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_NetData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.m_UrlConnection = nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //NSLog(@"m_NetData = %s", [m_NetData bytes]);
    
    
    
    //NSString *dicJson = [[NSString alloc]initWithData:m_NetData encoding:NSUTF8StringEncoding];
    
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    
    NSDictionary *dic = [jsonDecoder objectWithData:m_NetData error:nil];
    NSLog(@"dic = %@", dic);
    
    NSArray *arrJson = [jsonDecoder objectWithData:m_NetData error:nil];
    NSLog(@"count = %lu", (unsigned long)arrJson.count);
    
    //NSLog(@"arrJson = %d", arrJson.count);

    
    for (int i = 0; i < [arrJson count]; i ++)
    {
        NSDictionary *dicOne = [arrJson objectAtIndex:i];
        
        CCHomeListData *homeListData = [[CCHomeListData alloc] init];
        NSNumberFormatter *numFormmater = [[NSNumberFormatter alloc] init];
        
        homeListData.m_StrPK = [numFormmater stringFromNumber:[dicOne objectForKey:@"pk"]];
        homeListData.m_StrAppName = [dicOne objectForKey:@"appName"];
        homeListData.m_StrAppCode = [dicOne objectForKey:@"appCode"];
        homeListData.m_StrCompany = [dicOne objectForKey:@"company"];
        homeListData.m_StrComPerson = [dicOne objectForKey:@"comPerson"];
        homeListData.m_StrComTel = [dicOne objectForKey:@"comTel"];
        homeListData.m_StrIcon = [NSString stringWithFormat:@"%@%@", IMAGE_FRONT, [dicOne objectForKey:@"icon"]];
        homeListData.m_StrAppKind = [dicOne objectForKey:@"appKind"];
        homeListData.m_StrAppClassCode = [dicOne objectForKey:@"appClassCode"];
        homeListData.m_StrAppSort = [numFormmater stringFromNumber:[dicOne objectForKey:@"appSort"]];
        homeListData.m_StrUrlGetnum = [dicOne objectForKey:@"urlGetnum"];
        homeListData.m_StrMessagePushFlag = [dicOne objectForKey:@"messagePushFlag"];
        homeListData.m_StrFlag = [dicOne objectForKey:@"flag"];
        homeListData.m_StrDefaultApp = [dicOne objectForKey:@"defaultApp"];
        homeListData.m_StrAppPackage = [dicOne objectForKey:@"appPackage"];
        homeListData.m_StrAppActivity = [dicOne objectForKey:@"appActivity"];
        homeListData.m_StrAppEntry = [dicOne objectForKey:@"appEntry"];
        homeListData.m_StrAppUrl = [dicOne objectForKey:@"appUrl"];
        
        [m_ArrHomeList addObject:homeListData];
        

    }
    
    if (delegate)
    {
        [delegate returnHome:YES andArrHomeList:m_ArrHomeList];
    }
}



@end

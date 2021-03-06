//
//  CCGetAppClass.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CCGetAppClass.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "Const.h"
#import "CCAppClassData.h"

@implementation CCGetAppClass

@synthesize m_NetData;
@synthesize m_UrlConnection;
@synthesize delegate;
@synthesize m_ArrAppList;


- (void)getAppClass:(NSString *)appUrl
{
    NSLog(@"appUrl = %@", appUrl);
    NSString *strUrl = [appUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:30.0];
    if (!request)
    {
        if (delegate)
        {
            [delegate returnAppClass:NO andArrAppClass:nil];
        }
        
        return;
    }
    
    NSString *strName = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_NAME_KEY];
    NSString *strValue = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_VALUE_KEY];
    NSString *strVersion = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_VERSION_KEY];
    NSString *strPath = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_PATH_KEY];
    NSString *strDomain = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_DOMAIN_KEY];
    //NSString *strExpiresdate = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_EXPIRESDATE_KEY];
    //NSString *strSessionOnly = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_SESSIONONLY_KEY];
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
    
    m_ArrAppList = [[NSMutableArray alloc] initWithCapacity:0];
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
    
    NSLog(@"m_NetData = %s", [m_NetData bytes]);
    
    //NSString *dicJson = [[NSString alloc]initWithData:m_NetData encoding:NSUTF8StringEncoding];
    
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    NSArray *arrJson = [jsonDecoder objectWithData:m_NetData error:nil];
    NSLog(@"arrJson = %@", arrJson);
    
    for (int index = 0; index < [arrJson count]; index ++)
    {
        NSDictionary *dicOneData = [arrJson objectAtIndex:index];
        
        CCAppClassData *appClassData = [[CCAppClassData alloc] init];
        
        appClassData.m_StrAppClass = [dicOneData objectForKey:@"appClass"];
        appClassData.m_StrAppClassName = [dicOneData objectForKey:@"appClassName"];
        appClassData.m_StrAppOrder = [dicOneData objectForKey:@"appOrder"];
        appClassData.m_StrAppIcon = [NSString stringWithFormat:@"%@%@", IMAGE_FRONT, [dicOneData objectForKey:@"icon"]];
        appClassData.m_StrPK = [dicOneData objectForKey:@"pk"];
        
        [m_ArrAppList addObject:appClassData];
    }
    
    if (delegate)
    {
        [delegate returnAppClass:YES andArrAppClass:m_ArrAppList];
    }
    
}



@end

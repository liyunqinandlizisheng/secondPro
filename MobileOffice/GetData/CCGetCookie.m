//
//  CCGetCookie.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/17.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CCGetCookie.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "Const.h"

@implementation CCGetCookie

@synthesize m_NetData;
@synthesize m_UrlConnection;
@synthesize delegate;
@synthesize m_ArrAppList;


- (void)getCookie:(NSString *)userName andPassWord:(NSString *)passWord
{
    CCGetTgt *getTgt = [[CCGetTgt alloc] init];
    getTgt.delegate = self;
    [getTgt getTgt:GETTGT andUserName:userName andPassWord:passWord];
    
//    NSLog(@"appUrl = %@", appUrl);
//    NSString *strUrl = [appUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]
//                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
//                                                            timeoutInterval:30.0];
//    if (!request)
//    {
//        if (delegate)
//        {
//            [delegate returnCookie:NO andDicCookie:nil];
//        }
//        
//        return;
//    }
//    
//    //    [request setHTTPMethod:@"POST"];
//    //
//    //    [request addValue:[NoteItem objectForKey:@"JSESSIONID"] forHTTPHeaderField:@"JSESSIONID"];
//    //
//    //    NSString *body=[NSString stringWithFormat:@"method=%@&mobile=%@&verfiCodeType=%@&verificationCode=%@",[NoteItem objectForKey:@"method"],[NoteItem objectForKey:@"mobile"],[NoteItem objectForKey:@"verfiCodeType"],[NoteItem objectForKey:@"verificationCode"]];
//    //
//    //    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    m_UrlConnection = [[NSURLConnection alloc] initWithRequest:request
//                                                      delegate:self];
//    
//    m_NetData = [[NSMutableData alloc] initWithLength:0];
//    
//    m_ArrAppList = [[NSMutableArray alloc] initWithCapacity:0];
}


//#pragma mark -
//#pragma mark Private Class Function
//- (BOOL)check404Error
//{
//    NSString *strData = [NSString stringWithFormat:@"%s", [m_NetData bytes]];
//    NSRange stuRange = [strData rangeOfString:@"404 Not Found"];
//    if(strData && stuRange.location != NSNotFound)
//    {
//        return YES;
//    }
//    return NO;
//}
//
//#pragma mark -
//#pragma mark NSURLConnectionDelegate
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
//{
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}
//
//
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    NSArray *trustedHosts = [NSArray arrayWithObjects:challenge.protectionSpace.host, nil];
//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
//        if ([trustedHosts containsObject:challenge.protectionSpace.host])
//            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
//    
//    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
//}
//
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    self.m_NetData = nil;
//    m_NetData = [[NSMutableData alloc] initWithCapacity:0];
//}
//
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [m_NetData appendData:data];
//}
//
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    
//    self.m_UrlConnection = nil;
//}
//
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    
//    NSLog(@"m_NetData = %s", [m_NetData bytes]);
//    
//    //NSString *dicJson = [[NSString alloc]initWithData:m_NetData encoding:NSUTF8StringEncoding];
//    
//    //JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
//    
//    
//}


#pragma mark -
#pragma mark CCGetTgtDelegate
- (void)returnTgt:(BOOL)bRet andTgt:(NSString *)strTgt
{
    if (!bRet)
    {
        return;
    }
    
    NSLog(@"tgt = %@", strTgt);
    
    CCGetST *getSt = [[CCGetST alloc] init];
    getSt.delegate = self;
    [getSt getSt:[NSString stringWithFormat:@"http://58.68.255.207:8080/cricas/v1/tickets/%@", strTgt] andUrl:@"http://10.3.2.4:8080/crimobile/index.jsp"];
}


#pragma mark -
#pragma mark CCGetStDelegate
- (void)returnSt:(BOOL)bRet andSt:(NSString *)strSt
{
    if (!bRet)
    {
        return;
    }
    
    NSLog(@"strSt = %@", strSt);
    
    NSString *strGetCookie = [NSString stringWithFormat:@"http://10.3.2.4:8080/crimobile/index.jsp?ticket=%@",strSt];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strGetCookie]
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:3];
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies])
    {
        NSLog(@"%@", cookie);
        
        if ([[cookie name] isEqualToString:@"JSESSIONID"])
        {
            NSString *strValue = [cookie value];
            if ([strValue length] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:strValue forKey:SESSION_VALUE_KEY];
            }
            
            NSString *strName = [cookie name];
            if ([strName length] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:strName forKey:SESSION_NAME_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSString *strVersion = [NSString stringWithFormat:@"%lu", (unsigned long)[cookie version]];
            if ([strVersion length] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:SESSION_VERSION_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSString *strDomain = [cookie domain];
            if ([strDomain length] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:SESSION_DOMAIN_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSString *strPath = [cookie path];
            if ([strPath length] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:SESSION_PATH_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSString *strSessionOnly = [NSString stringWithFormat:@"%d", [cookie isSessionOnly]];
            if ([strSessionOnly length] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:strSessionOnly forKey:SESSION_SESSIONONLY_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSString *strSecureOnly = [NSString stringWithFormat:@"%d", [cookie isSecure]];
            if ([strSecureOnly length] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:strSecureOnly forKey:SESSION_SECURE_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }
    
    if (delegate)
    {
        [delegate returnCookie:YES];
    }
}

@end

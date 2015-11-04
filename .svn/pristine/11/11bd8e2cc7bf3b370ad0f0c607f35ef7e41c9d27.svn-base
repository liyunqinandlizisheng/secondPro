//
//  CCSetReadOrNotRead.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CCSetReadOrNotRead.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "Const.h"

@implementation CCSetReadOrNotRead

@synthesize m_NetData;
@synthesize m_UrlConnection;
@synthesize delegate;
@synthesize m_ArrAppList;


- (void)setIsReadStatus:(NSString *)apiUrl andPK:(NSString *)strPK
{
    NSLog(@"strUrl = %@", apiUrl);
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", apiUrl, strPK];
    
    NSString *strFinalUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strFinalUrl]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:30.0];
    if (!request)
    {
        if (delegate)
        {
            [delegate returnAppClass:NO];
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
    
    //JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    
    
}


@end

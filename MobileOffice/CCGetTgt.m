//
//  CCGetTgt.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CCGetTgt.h"
#import "AppDelegate.h"
#import "TFHpple.h"

@implementation CCGetTgt

@synthesize m_UrlConnection;
@synthesize m_NetData;
@synthesize delegate;

- (void)getTgt:(NSString *)tgtUrl
{
    NSString *strUrl = [tgtUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:30.0];
    if (!request)
    {
        if (delegate)
        {
            [delegate returnTgt:NO andTgt:nil];
        }
        
        return;
    }
    
    [request setHTTPMethod:@"POST"];
    
//        [request addValue:[NoteItem objectForKey:@"JSESSIONID"] forHTTPHeaderField:@"JSESSIONID"];
//    
//        NSString *body=[NSString stringWithFormat:@"method=%@&mobile=%@&verfiCodeType=%@&verificationCode=%@",[NoteItem objectForKey:@"method"],[NoteItem objectForKey:@"mobile"],[NoteItem objectForKey:@"verfiCodeType"],[NoteItem objectForKey:@"verificationCode"]];
    
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@", @"admin", @"admin"];
    NSLog(@"body = %@", body);
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    m_UrlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self];
    
    m_NetData = [[NSMutableData alloc] initWithLength:0];
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

    //  截取网页的方法，这次没用到
//    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:m_NetData];
//    NSArray *elements = [xpathParser search:@"//h1"];
//    
//    NSLog(@"count = %d", elements.count);
//
//    TFHppleElement *element = [elements objectAtIndex:0];
//    NSString *nodeContent = [element tagName];
//    NSLog(@"nodeContent = %@", nodeContent);
    
    NSLog(@"m_NetData = %s", [m_NetData bytes]);
    
    NSString *strData = [[NSString alloc]initWithData:m_NetData encoding:NSUTF8StringEncoding];
    
    NSString *strBehind = [[strData componentsSeparatedByString:@"http://58.68.255.207:8080/cricas/v1/tickets/"] objectAtIndex:1];
    NSLog(@"str = %@", strBehind);
    NSString *strTgt = [[strBehind componentsSeparatedByString:@"method="] objectAtIndex:0];
    NSLog(@"fi = %@", strTgt);
    
    NSString *strFinalTgt = [strTgt substringToIndex:strTgt.length-2];
    NSLog(@"strFinalTgt = %@", strFinalTgt);
    
    if (delegate)
    {
        [delegate returnTgt:YES andTgt:strFinalTgt];
    }
}


@end

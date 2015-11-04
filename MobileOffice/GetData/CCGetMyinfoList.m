//
//  CCGetMyinfoList.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/19.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CCGetMyinfoList.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "CCMyinfoData.h"

@implementation CCGetMyinfoList
@synthesize m_NetData;
@synthesize m_UrlConnection;
@synthesize delegate;
@synthesize m_ArrAppList;


- (void)getMyinfoList:(NSString *)myinfoUrl
{
    NSLog(@"myinfoUrl = %@", myinfoUrl);
    NSString *strUrl = [myinfoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:30.0];
    if (!request)
    {
        if (delegate)
        {
            [delegate returnMyinfoList:NO andArrMyinfoList:nil];
        }
        
        return;
    }
    
    m_UrlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self];    
    m_NetData = [[NSMutableData alloc] initWithLength:0];
    
    m_ArrAppList = [[NSMutableArray alloc] initWithCapacity:0];
}
#pragma mark 
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
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    NSDictionary *dicJson = [jsonDecoder objectWithData:m_NetData error:nil];
    
    NSLog(@"dic = %@", dicJson);
    
    if (dicJson == NULL) {
        return;
    }
    NSMutableArray  *muArrMyinfoList = [[NSMutableArray alloc] initWithCapacity:0];
    CCMyinfoData *myinfoData = [[CCMyinfoData alloc] init];
    
    myinfoData.userName = dicJson[@"username"];
    myinfoData.userCode = dicJson[@"usercode"];
    myinfoData.email = dicJson[@"email"];
    myinfoData.mobileTel = dicJson[@"mobileTel"];
    myinfoData.tel = dicJson[@"tel"];
    myinfoData.deptNameStr = dicJson[@"deptName"];
    
    [muArrMyinfoList addObject:myinfoData];
    
    if (delegate)
    {
        [delegate returnMyinfoList:YES andArrMyinfoList:muArrMyinfoList];
    }
}

@end

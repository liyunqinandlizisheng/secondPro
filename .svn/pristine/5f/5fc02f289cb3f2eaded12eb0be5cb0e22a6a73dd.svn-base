//
//  CCGetMessageList.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/13.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CCGetMessageList.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "Const.h"
#import "CCMessageData.h"

@implementation CCGetMessageList

@synthesize m_NetData;
@synthesize m_UrlConnection;
@synthesize delegate;
@synthesize m_ArrAppList;

- (void)getMessageList:(NSString *)messageUrl
{
    NSLog(@"messageUrl = %@", messageUrl);
    NSString *strUrl = [messageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:30.0];
    if (!request)
    {
        if (delegate)
        {
            [delegate returnMessageList:NO andArrMessageList:nil];
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
    
    //NSLog(@"m_NetData = %s", [m_NetData bytes]);
    
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    NSArray *arrJson = [jsonDecoder objectWithData:m_NetData error:nil];
    
    NSLog(@"dic = %@", arrJson);
    
    NSMutableArray *muArrMessageList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int index = 0; index < arrJson.count; index ++)
    {
        NSDictionary *dicOne = [arrJson objectAtIndex:index];
        
        CCMessageData *messageData = [[CCMessageData alloc] init];
        NSNumberFormatter *numFormmater = [[NSNumberFormatter alloc] init];
        
        messageData.m_StrMsgContent = [dicOne objectForKey:@"msgContent"];
        messageData.m_StrMsgHref = [dicOne objectForKey:@"msgHref"];
        messageData.m_StrMsgLevel = [numFormmater stringFromNumber:[dicOne objectForKey:@"msgLevel"]];
        messageData.m_StrMsgTitle = [dicOne objectForKey:@"msgTitle"];
        messageData.m_StrPK = [numFormmater stringFromNumber:[dicOne objectForKey:@"pk"]];
        messageData.m_StrReadFlag = [dicOne objectForKey:@"readFlag"];
        messageData.m_StrReadTime = [dicOne objectForKey:@"readTime"];
        messageData.m_StrReceiverDeptCodes = [dicOne objectForKey:@"receiverDeptCodes"];
        messageData.m_StrReceiverUserCodes = [dicOne objectForKey:@"receiverUserCodes"];
        messageData.m_StrSendPerson = [dicOne objectForKey:@"sendPerson"];
        messageData.m_StrSendTime = [dicOne objectForKey:@"sendTime"];
        messageData.m_StrSystemCode = [dicOne objectForKey:@"systemCode"];
        messageData.m_StrSystemIcon = [NSString stringWithFormat:@"%@%@", IMAGE_FRONT, [dicOne objectForKey:@"systemIcon"]];
        messageData.m_StrSystemName = [dicOne objectForKey:@"systemName"];
        messageData.m_StrUsercode = [dicOne objectForKey:@"usercode"];
        
        [muArrMessageList addObject:messageData];
    }
    
    if (delegate)
    {
        [delegate returnMessageList:YES andArrMessageList:muArrMessageList];
    }
    
    
}


@end

//
//  SplitDns.m
//  Extension
//
//  Created by ye donggang on 2022/11/6.
//  Copyright © 2022 Objective-See. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SplitDns.h"

@implementation SplitDnsNode

-(id)init {
    self = [super initWithKey:@"." andValue:nil];
    return self;
}

+(void)routeAddHost:(NSString *)host gateway:(NSString *)gateway {
    NSString *cmdStr = [NSString stringWithFormat:@"route add -host %@ %@", host, gateway];
    const char* cmd = [cmdStr UTF8String];
    system(cmd);
}

+(void)routeDelHost:(NSString *)host gateway:(NSString *)gateway {
    NSString *cmdStr = [NSString stringWithFormat:@"route delete -host %@ %@", host, gateway];
    const char* cmd = [cmdStr UTF8String];
    system(cmd);
}

//config format: "server=/zzcloud.me/169.254.169.254#53/vpn", see https://github.com/cokebar/gfwlist2dnsmasq
+(id)initFromFile:(NSString *)filePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData *fileData = [fm contentsAtPath:filePath];
    NSString *fileContent = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    NSArray<NSString *> *dnsConfigs = [fileContent componentsSeparatedByString:@"\n"];
    SplitDnsNode *root = [[SplitDnsNode alloc] init];
    
    NSUInteger count = dnsConfigs.count;
    for (NSUInteger i=0; i<count; i++) {
        NSString *dnsConfig = [dnsConfigs objectAtIndex:i];
        if ([dnsConfig containsString:@"server="]) {
            NSArray<NSString *> *dnsConfigArray = [dnsConfig componentsSeparatedByString: @"/"];
            if (dnsConfigArray != nil && [dnsConfigArray count] >= 3) {
                NSDictionary *value;
                if (dnsConfigArray != nil && [dnsConfigArray count] > 3) {
                    value = [NSDictionary dictionaryWithObjectsAndKeys:[dnsConfigArray objectAtIndex:2], @"dnsserver", [dnsConfigArray objectAtIndex:3], @"gateway", nil];
                } else {
                    value = [NSDictionary dictionaryWithObjectsAndKeys:[dnsConfigArray objectAtIndex:2], @"dnsserver", nil, @"gatewat", nil];
                }
                [root sinsert:[[dnsConfigArray objectAtIndex:1] componentsSeparatedByString:@"."]  andValue:value];
            }
        }
    }
    
    return root;
}

@end


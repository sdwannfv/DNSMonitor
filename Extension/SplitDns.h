//
//  SplitDns.h
//  DNSMonitor
//
//  Created by ye donggang on 2022/11/6.
//  Copyright © 2022 Objective-See. All rights reserved.
//

#ifndef SplitDns_h
#define SplitDns_h

#import "SuffixTreeNode.h"

@interface SplitDnsNode : SuffixTreeNode
-(id)init;
+(void)routeAddHost:(NSString *)host gateway:(NSString *)gateway;
+(void)routeDelHost:(NSString *)host gateway:(NSString *)gateway;
+(id)initFromFile:(NSString *)filePath;
@end

#endif /* SplitDns_h */

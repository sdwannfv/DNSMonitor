//
//  SuffixTreeNode.h
//  DNSMonitor
//
//  Created by ye donggang on 2022/11/6.
//  Copyright © 2022 Objective-See. All rights reserved.
//

#ifndef SuffixTreeNode_h
#define SuffixTreeNode_h

typedef NSString *(^customDesciption)(id value);

extern NSString *(^dnsCustomDescription)(id);

@interface SuffixTreeNode:NSObject {
    NSString *_key;
    id _value;
    NSMutableDictionary<NSString *, SuffixTreeNode *> *_childen;
}
-(id)initWithKey:(NSString *)key andValue:(NSDictionary *)value;
-(void)insert:(NSString *)key  andValue:(id)value;
-(void)sinsert:(NSArray<NSString *> *)keys  andValue:(id)value;
-(id)search:(NSArray<NSString *> *)keys;
-(NSString *)descriptionWithPrefix:(NSString *)prefix andIndent:(NSString *)indent;
-(NSString *)descriptionWithPrefix:(NSString *)prefix andIndent:(NSString *)indent andCustomDescription:(customDesciption)customDesc;
@end

#endif /* SuffixTreeNode_h */

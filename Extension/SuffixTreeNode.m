//
//  SuffixTreeNode.m
//  Extension
//
//  Created by ye donggang on 2022/11/6.
//  Copyright © 2022 Objective-See. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuffixTreeNode.h"

NSString *(^dnsCustomDescription)(id) =
    ^(id value) {
        return [NSString stringWithFormat:@"%@ %@", value[@"dnsserver"], value[@"gateway"]];
    };

@implementation SuffixTreeNode
-(id)initWithKey:(NSString *)key andValue:(NSDictionary *)value {
    self = [super init];
    _key = key;
    _value = value;
    _childen = [[NSMutableDictionary alloc]init];
    return self;
}

-(void)insert:(NSString *)key andValue:(id)value {
    SuffixTreeNode *node = [[SuffixTreeNode alloc] initWithKey:key andValue:value];
    _childen[key] = node;
}

-(void)sinsert:(NSArray<NSString *> *)keys andValue:(id)value {
    if ([keys count] == 0) {
        return;
    }
    
    NSString *key = [keys lastObject];
    
    if ([keys count] > 1) {
        SuffixTreeNode *node = _childen[key];
        if (node == nil) {
            _childen[key] = [[SuffixTreeNode alloc] initWithKey:key andValue:nil];
        }
        node = _childen[key];
        
        NSArray<NSString *> *subkeys = [keys subarrayWithRange:NSMakeRange(0, [keys count] - 1)];
        [node sinsert:subkeys andValue:value];
        return;
    }
    
    if (_childen[key] == nil) {
        [self insert:key andValue:value];
    } else {
        _childen[key]->_value = value;
    }
}

-(NSDictionary *)search:(NSArray<NSString *> *)keys {
    if ([keys count]  == 0) {
        return _value;
    }

    NSString *key = [keys lastObject];
    if (_childen[key] == nil) {
        return _value;
    }

    NSArray<NSString *> *subkeys = [keys subarrayWithRange:NSMakeRange(0, [keys count] - 1)];
    SuffixTreeNode *node = _childen[key];
    return [node search: subkeys];
}

-(NSString *)descriptionWithPrefix:(NSString *)prefix andIndent:(NSString *)indent {
    NSString *desc = [NSString stringWithFormat:@"%@%@->%@\n", prefix, _key, _value];
    for (id key in _childen) {
        NSString *childDesc;
        NSString *childPrefix = [prefix stringByAppendingString:indent];
        childDesc = [_childen[key] descriptionWithPrefix:childPrefix andIndent:indent];
        desc = [desc stringByAppendingFormat:@"%@", childDesc];
    }
    return desc;
}

-(NSString *)descriptionWithPrefix:(NSString *)prefix andIndent:(NSString *)indent andCustomDescription:(customDesciption)customDesc {
    NSString *desc = [NSString stringWithFormat:@"%@%@ --> %@\n", prefix, _key, customDesc(_value)];
    for (id key in _childen) {
        NSString *childDesc;
        NSString *childPrefix = [prefix stringByAppendingString:indent];
        childDesc = [_childen[key] descriptionWithPrefix:childPrefix andIndent:indent andCustomDescription:customDesc];
        desc = [desc stringByAppendingFormat:@"%@", childDesc];
    }
    return desc;
}
@end

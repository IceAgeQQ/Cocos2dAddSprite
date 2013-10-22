//
//  addSprite.m
//  2dAddSprite
//
//  Created by Chao Xu on 13-8-4.
//  Copyright (c) 2013年 Chao Xu. All rights reserved.
//

#import "addSprite.h"

@implementation addSprite

-(id) init{
    if ((self = [super init])) {
        CCSprite *sprite = [CCSprite spriteWithFile:@"football.png"];
        [self addChild:sprite];
        
    }
    return self;
}
@end

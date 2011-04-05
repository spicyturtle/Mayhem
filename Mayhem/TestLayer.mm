//
//  TestLayer.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "TestLayer.h"


@implementation TestLayer

@synthesize player = _player;

- (id)init {
    self = [super init];
    if (self) {
        
        // Get winSize
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Add objects to layer here
        self.player = [[Player alloc] init];
        self.player.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_player];
    }
    return self;
}

@end

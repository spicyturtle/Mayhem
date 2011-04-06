//
//  TestLayer.mm
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "TestLayer.h"


@implementation TestLayer

@synthesize player = _player;

+(TestLayer *)layerWithWorld:(b2World *)world andPlayer:(Player *)player
{
    return [[self alloc] initWithWorld:world andPlayer:player];
}

- (id)init {
    self = [super init];
    if (self) {
        
        // Get winSize
        CGSize winSize = GET_WINSIZE();
        
        _world = [World getWorld];
                
        // Add objects to layer here
        self.player = [[Player alloc] initWithWorld:_world];
        self.player.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_player];
        
        [self runAction:[CCFollow actionWithTarget:_player]];
        
        [self schedule:@selector(tick:)];
        
    }
    return self;
}

- (id)initWithWorld: (b2World *)world andPlayer:(Player *)player {
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
    if (self) {
        
        CGSize winSize = GET_WINSIZE();
        
        _world = world;
        
        // Add objects to layer here
        self.player = player;
        [self addChild:_player];
        
        [self runAction:[CCFollow actionWithTarget:_player worldBoundary:CGRectMake(0, 0, winSize.width, winSize.height)]];
        
        [self schedule:@selector(tick:)];
        
    }
    return self;
}

-(void)tick:(ccTime) dt
{
    _world->Step(dt, 10, 10);    
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {    
        if (b->GetUserData() != NULL) {
            CCSprite *sprite = (CCSprite *)b->GetUserData();                        
            sprite.position = ccp(b->GetPosition().x * PTM_RATIO,
                                  b->GetPosition().y * PTM_RATIO);
            sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }        
    }
}

@end

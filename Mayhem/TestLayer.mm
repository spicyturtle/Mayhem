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
        CGSize winSize = GET_WINSIZE();
        
        // -----------------------------------------------------
            // This can be put into a new class, world.mm ?
            // Highly reuseable, all game scenes will probably have this ;)
        // -----------------------------------------------------
        // Create a world
        b2Vec2 gravity = b2Vec2(0.0f, -0.4f);
        bool doSleep = true;
        _world = new b2World(gravity, doSleep);
        
        // Create edges around the entire screen
        b2BodyDef groundBodyDef;
        groundBodyDef.position.Set(0,0);
        b2Body *_groundBody = _world->CreateBody(&groundBodyDef);
        b2PolygonShape groundBox;
        b2FixtureDef groundBoxDef;
        groundBoxDef.shape = &groundBox;
        // Top wall
        groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(winSize.width/PTM_RATIO, 0));
        _groundBody->CreateFixture(&groundBoxDef);
        // Left Wall
        groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(0, winSize.height/PTM_RATIO));
        _groundBody->CreateFixture(&groundBoxDef);
        // Bottom wall
        groundBox.SetAsEdge(b2Vec2(0, winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO));
        _groundBody->CreateFixture(&groundBoxDef);
        // Right wall
        groundBox.SetAsEdge(b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO, 0));
        _groundBody->CreateFixture(&groundBoxDef);
        // -----------------------------------------------------
        
        
        // Add objects to layer here
        self.player = [[Player alloc] initWithWorld:_world];
        self.player.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_player];
        
        [self runAction:[CCFollow actionWithTarget:_player]];
        
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

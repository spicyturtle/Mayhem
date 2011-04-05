//
//  Player.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "Player.h"


@implementation Player

- (id)initWithWorld:(b2World *) world {
    self = [super init];
    if (self) {
        
        CGSize winSize = GET_WINSIZE();
        
        // Set self to be a Sprite from a file.
        self = [CCSprite spriteWithFile:@"player.png" rect:CGRectMake(0, 0, 64, 64)];
        
        // Create player body
        b2BodyDef playerBodyDef;
        playerBodyDef.type = b2_dynamicBody;
        playerBodyDef.position.Set(winSize.width/(2*PTM_RATIO), winSize.height/(2*PTM_RATIO));
        playerBodyDef.userData = self;
        _playerBody = world->CreateBody(&playerBodyDef);
        
        // Create player shape
        b2PolygonShape playerShape;
        playerShape.SetAsBox(self.contentSize.width/(2*PTM_RATIO), self.contentSize.height/(2*PTM_RATIO));
        
        // Create shape definition and add to body
        b2FixtureDef playerShapeDef;
        playerShapeDef.shape = &playerShape;
        playerShapeDef.density = 5.0f;
        playerShapeDef.friction = 0.5f;
        playerShapeDef.restitution = 0.1f;
        _playerFixture = _playerBody->CreateFixture(&playerShapeDef);
    }
    return self;
}

- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

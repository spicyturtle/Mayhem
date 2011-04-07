//
//  StaticEnemy.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/7/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "StaticEnemy.h"


@implementation StaticEnemy

+(StaticEnemy *)enemyInWorld:(b2World *)world
{
    return [[self alloc] initWithWorld:world];
}


- (id)initWithWorld:(b2World *)world {
    self = [super initWithFile:@"StaticEnemy.png"];
    if (self) {
        // Initialize enemy
        
//        CGSize winSize = GET_WINSIZE();
        
        // Create enemy body
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(60.0/PTM_RATIO, 160.0/PTM_RATIO);
        bodyDef.userData = self;
        _body = world->CreateBody(&bodyDef);
        
        // Create player shape
        b2CircleShape shape;
        shape.m_radius = 16.0/PTM_RATIO;
        
        // Create shape definition
        b2FixtureDef shapeDef;
        shapeDef.shape = &shape;
        shapeDef.density = 1.0f;
        shapeDef.friction = 1.0f;
        shapeDef.restitution = 0.1f;
        _fixture = _body->CreateFixture(&shapeDef);
        
    }
    return self;
}

@end

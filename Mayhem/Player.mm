//
//  Player.mm
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "Player.h"

@implementation Player

+(Player *)playerInWorld:(b2World *)world
{
    return [[self alloc] initWithWorld:world];
}

- (id)initWithWorld:(b2World *) world {
    
    self = [super initWithFile:@"player.png" rect:CGRectMake(0, 0, 64, 64)];
    if (self) {
        
        CGSize winSize = GET_WINSIZE();

        // Create player body
        b2BodyDef playerBodyDef;
        playerBodyDef.type = b2_dynamicBody;
        playerBodyDef.position.Set(winSize.width/(2*PTM_RATIO), winSize.height/(2*PTM_RATIO));
        playerBodyDef.userData = self;
        _playerBody = world->CreateBody(&playerBodyDef);
        
        _playerBody->SetAngularDamping(1.0f);
        
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

-(void)turnLeft
{
    _playerBody->ApplyAngularImpulse(8.0f);
    
}

-(void)turnRight
{
    _playerBody->ApplyAngularImpulse(-8.0f);
}

-(Weapon*)fire
{
    b2World *world = _playerBody->GetWorld();
    
    b2Vec2 testpoint = _playerBody->GetPosition();
    
    Weapon *bullet = [[Weapon alloc] initWithWorld:world point:testpoint];
    
    return bullet;
    
}

-(void)accelerate
{
    float32 magnitude = 8.0f;
    // Calculate current rotation
    float32 rot = _playerBody->GetAngle();
    
    // Set linear impulse in rotational direction
    b2Vec2 impulse = b2Vec2(magnitude*cosf(rot + M_PI/2), magnitude*sinf(rot+ M_PI/2));
    
    b2Vec2 pointOfImpulse = _playerBody->GetPosition();
    _playerBody->ApplyLinearImpulse(impulse, pointOfImpulse);
}

- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

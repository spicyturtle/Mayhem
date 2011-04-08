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
    
    self = [super initWithFile:@"player.png" rect:CGRectMake(2, 2, 61, 59)];
    if (self) {
        
        CGSize winSize = GET_WINSIZE();

        // Testing SpriteHelper
        
        int player_positionX = winSize.width/2; //PUT YOUR OWN VALUE HERE
        int player_positionY = winSize.height/2; //PUT YOUR OWN VALUE HERE

        position_ = ccp(player_positionX, player_positionY);
        b2BodyDef player_BodyDef;
        player_BodyDef.type = b2_dynamicBody;
        player_BodyDef.position.Set(player_positionX/PTM_RATIO, player_positionY/PTM_RATIO);
        player_BodyDef.userData = self;
        _playerBody = world->CreateBody(&player_BodyDef);
        
        b2PolygonShape player_Shape;
        int dimension = 7;
        b2Vec2 vertices[] = {
            b2Vec2(14.516872f / PTM_RATIO, -28.650311f / PTM_RATIO),
            b2Vec2(29.641876f / PTM_RATIO, -17.025311f / PTM_RATIO),
            b2Vec2(29.266876f / PTM_RATIO, -0.650311f / PTM_RATIO),
            b2Vec2(-0.108128f / PTM_RATIO, 29.224689f / PTM_RATIO),
            b2Vec2(-29.733126f / PTM_RATIO, -1.025311f / PTM_RATIO),
            b2Vec2(-29.358126f / PTM_RATIO, -16.900307f / PTM_RATIO),
            b2Vec2(-14.483126f / PTM_RATIO, -28.775307f / PTM_RATIO)};
        player_Shape.Set(vertices, dimension);
        b2FixtureDef player_ShapeDef;
        player_ShapeDef.shape = &player_Shape;
        player_ShapeDef.density = 5.0f;
        player_ShapeDef.friction = 0.5f;
        player_ShapeDef.restitution = 0.1f;
        _playerFixture = _playerBody->CreateFixture(&player_ShapeDef);
        // end
        
        
        _playerBody->SetAngularDamping(1.0f);
        
        // Set initial fuel value
        _fuel = 10.0f;
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
    
    Weapon *bullet = [[Weapon alloc] initWithWorld:world point:testpoint angle:_playerBody->GetAngle()];
    
    return bullet;
    
}

-(void)accelerate
{
    float32 magnitude = 8.0f ;
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

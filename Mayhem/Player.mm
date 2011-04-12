//
//  Player.mm
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize fuel = _fuel;
@synthesize particleEmitter = _particleEmitter;

+(Player *)playerInWorld:(b2World *)world
{
    return [[self alloc] initWithWorld:world];
}

- (id)initWithWorld:(b2World *) world {
    
    self = [super initWithFile:@"player.png" rect:CGRectMake(2, 2, 30, 44)];
    if (self) {
         self.tag = PLAYER;
        
        CGSize winSize = GET_WINSIZE();

        // Testing SpriteHelper

        int player_positionX = winSize.width/2; 
        int player_positionY = winSize.height/2;
        
        position_ = ccp(player_positionX, player_positionY);
        b2BodyDef player_BodyDef;
        player_BodyDef.type = b2_dynamicBody;
        player_BodyDef.position.Set(player_positionX/PTM_RATIO, player_positionY/PTM_RATIO);
        player_BodyDef.userData = self;
        _playerBody = world->CreateBody(&player_BodyDef);
        
        b2PolygonShape player_Shape;
        int dimension = 7;
        b2Vec2 vertices[] = {
            b2Vec2(12.875000f / PTM_RATIO, 2.000000f / PTM_RATIO),
            b2Vec2(0.250000f / PTM_RATIO, 21.250000f / PTM_RATIO),
            b2Vec2(-13.500000f / PTM_RATIO, 0.250000f / PTM_RATIO),
            b2Vec2(-13.375000f / PTM_RATIO, -12.125000f / PTM_RATIO),
            b2Vec2(-4.875000f / PTM_RATIO, -18.750000f / PTM_RATIO),
            b2Vec2(4.625000f / PTM_RATIO, -18.875000f / PTM_RATIO),
            b2Vec2(12.875000f / PTM_RATIO, -13.750000f / PTM_RATIO)};
        player_Shape.Set(vertices, dimension);
        b2FixtureDef player_ShapeDef;
        player_ShapeDef.shape = &player_Shape;
        player_ShapeDef.density = 12.0f;
        player_ShapeDef.friction = 0.5f;
        player_ShapeDef.restitution = 0.1f;
        _playerFixture = _playerBody->CreateFixture(&player_ShapeDef);
        _playerBody->SetAngularDamping(2.0f);
        
        // Set initial fuel value
        _fuel = FUEL_MAX;
        
        
        [self schedule:@selector(playerGameLogic:) interval:1.0f];

    }
    
    return self;
}

-(void)turnLeft
{
    _playerBody->ApplyAngularImpulse(2.0f);
}

-(void)turnRight
{
    _playerBody->ApplyAngularImpulse(-2.0f);
}

-(Weapon*)fire
{
    b2World *world = _playerBody->GetWorld();
    b2Vec2 pos = _playerBody->GetPosition();
    
    Weapon *bullet = [[Weapon alloc] initWithWorld:world point:pos angle:_playerBody->GetAngle() size:self.contentSize type:PLAYER_WEAPON];
    
    return bullet;
    
}

-(void)accelerate
{
    float32 magnitude = 16.0f ;
    // Calculate current rotation
    float32 rot = _playerBody->GetAngle();
    
    // Set linear impulse in rotational direction
    b2Vec2 impulse = b2Vec2(magnitude*cosf(rot + M_PI/2), magnitude*sinf(rot+ M_PI/2));
    
    b2Vec2 pointOfImpulse = _playerBody->GetPosition();
    _playerBody->ApplyLinearImpulse(impulse, pointOfImpulse);
    
    _fuel -= 1.0f;
    
    [_particleEmitter setPosition:ccp(pointOfImpulse.x*PTM_RATIO, pointOfImpulse.y*PTM_RATIO)];
    [_particleEmitter setLife:1.0f];
    
    
    

}

-(float32)getAngle{
    float32 radians = _playerBody->GetAngle();
    float32 angle = float32((int(radians*180/M_PI))%360);
    return abs(angle);
}
-(void)playerGameLogic:(ccTime)dt {
    

}

-(void)refuel {
    if(_fuel < FUEL_MAX)
        _fuel += 0.5f;
    
}


- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

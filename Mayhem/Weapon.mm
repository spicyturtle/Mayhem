//
//  Weapon.mm
//  Mayhem
//
//  Created by Kim Sørensen on 4/6/11.
//  Copyright 2011 SpicyTurtle. All rights reserved.
//

#import "Weapon.h"


@implementation Weapon

+(Weapon *)WeaponInWorld:(b2World *)world point:(b2Vec2)pos angle:(float32)angle size:(CGSize)size type:(int)type
{   
    return [[self alloc] initWithWorld:world point:pos angle:(float32)angle size:(CGSize)size type:(int)type];
}

- (id)initWithWorld:(b2World *)world point:(b2Vec2)pos angle:(float32)angle size:(CGSize)size type:(int)type{
    
    NSString *imageName;
    float32 magnitude;
    if (type == ENEMY_WEAPON){
        imageName = @"redLaserRay.png";
        magnitude = ENEMY_WEAPON_VELOCITY;
    }
    
    else if (type == PLAYER_WEAPON){
        imageName = @"greenLaserRay.png";
        magnitude = PLAYER_WEAPON_VELOCITY;
        }
    
        
    self = [super initWithFile:imageName rect:CGRectMake(2,2, 2, 15)];
    if (self) {

        self.tag = type;
        
        float32 xoffset = size.width/(PTM_RATIO*2)+1;
        float32 yoffset = size.height/(PTM_RATIO*2)+1;
        b2Vec2 posimpulse = b2Vec2(xoffset*cosf(angle+M_PI/2),yoffset*sinf(angle+M_PI/2));
        b2Vec2 startPos = b2Vec2(pos.x+posimpulse.x, pos.y+posimpulse.y);
        
        int greenLaserRay_positionX = (startPos.x)*PTM_RATIO; //PUT YOUR OWN VALUE HERE
        int greenLaserRay_positionY = (startPos.y)*PTM_RATIO; //PUT YOUR OWN VALUE HERE
        position_ = ccp(greenLaserRay_positionX, greenLaserRay_positionY);
        
        // Create weapon body
        b2BodyDef weaponBodyDef; 
        weaponBodyDef.type = b2_dynamicBody;
        weaponBodyDef.position.Set(greenLaserRay_positionX/PTM_RATIO, greenLaserRay_positionY/PTM_RATIO);
        weaponBodyDef.userData = self;
        _weaponBody = world->CreateBody(&weaponBodyDef);
        
        int dimension = 4;
        
        // Create weapon shape
        b2PolygonShape weaponShape;
        b2Vec2 vertices[] = {
            b2Vec2(0.875000f / PTM_RATIO, -7.625000f / PTM_RATIO),
            b2Vec2(1.125000f / PTM_RATIO, 7.250000f / PTM_RATIO),
            b2Vec2(-0.750000f / PTM_RATIO, 7.375000f / PTM_RATIO),
            b2Vec2(-0.875000f / PTM_RATIO, -7.625000f / PTM_RATIO)};
        weaponShape.Set(vertices, dimension);
        // Create shape definition and add to body
        b2FixtureDef weaponShapeDef;
        weaponShapeDef.shape = &weaponShape;
        weaponShapeDef.density = 0.0f; //PUT YOUR OWN VALUE HERE 
        weaponShapeDef.friction = 0.0f; //PUT YOUR OWN VALUE HERE
        weaponShapeDef.restitution = 0.0f; //PUT YOUR OWN VALUE HERE
        weaponShapeDef.filter.groupIndex = -1;
        _weaponFixture = _weaponBody->CreateFixture(&weaponShapeDef);
        
        _weaponBody->SetTransform(startPos, angle);
        
        // Set linear impulse in rotational direction
        b2Vec2 impulse = b2Vec2(magnitude*cosf(angle + M_PI/2), magnitude*sinf(angle+ M_PI/2));
        
        b2Vec2 pointOfImpulse = _weaponBody->GetPosition();
        _weaponBody->SetLinearVelocity(impulse);
    }
    
    return self;
}



- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

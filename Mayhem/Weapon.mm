//
//  Weapon.mm
//  Mayhem
//
//  Created by Kim Sørensen on 4/6/11.
//  Copyright 2011 SpicyTurtle. All rights reserved.
//

#import "Weapon.h"


@implementation Weapon

+(Weapon *)WeaponInWorld:(b2World *)world point:(b2Vec2)pos angle:(float32)angle 
{   
    return [[self alloc] initWithWorld:world point:pos angle:(float32)angle];
}

- (id)initWithWorld:(b2World *)world point:(b2Vec2)pos angle:(float32)angle{
    
        
    self = [super initWithFile:@"redLaserRay.png" rect:CGRectMake(2,2, 2, 15)];
    if (self) {

        float32 xoffset = 1.1f;
        float32 yoffset = 1.1f;
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
        weaponShapeDef.density = 0.1f; //PUT YOUR OWN VALUE HERE 
        weaponShapeDef.friction = 0.0f; //PUT YOUR OWN VALUE HERE 
        weaponShapeDef.restitution = 1.0f; //PUT YOUR OWN VALUE HERE
        weaponShapeDef.filter.groupIndex = -1;
        _weaponFixture = _weaponBody->CreateFixture(&weaponShapeDef);
        
        _weaponBody->SetTransform(startPos, angle);
        _weaponBody->SetBullet(true);
        //    _weaponBody->ApplyAngularImpulse(angle);
        float32 magnitude = 0.1f;
        // Set linear impulse in rotational direction
        b2Vec2 impulse = b2Vec2(magnitude*cosf(angle + M_PI/2), magnitude*sinf(angle+ M_PI/2));
        
        
        b2Vec2 pointOfImpulse = _weaponBody->GetPosition();
        _weaponBody->ApplyLinearImpulse(impulse, pointOfImpulse);
    }
    
    return self;
}



- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

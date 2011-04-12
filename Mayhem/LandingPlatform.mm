//
//  LandingPlatform.mm
//  Mayhem
//
//  Created by Roger Hansen on 4/10/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "LandingPlatform.h"

@implementation LandingPlatform

+(LandingPlatform *)landingPlatformInWorld:(b2World *)world
{
    return [[self alloc] initWithWorld:world];
}

- (id)initWithWorld:(b2World *) world {
    
    self = [super initWithFile:@"landingPad.png" rect:CGRectMake(0, 0, 100, 20)];
    if (self) {
        self.tag = PLATFORM;
        int landing_positionX = 100; //PUT YOUR OWN VALUE HERE
        int landing_positionY = 100; //PUT YOUR OWN VALUE HERE
        CCSprite *landing_Sprite = [CCSprite spriteWithFile:@"landingPad.png" rect:CGRectMake(0,0, 100, 20)];
        landing_Sprite.position = ccp(landing_positionX, landing_positionY);
        b2BodyDef landing_BodyDef;
        landing_BodyDef.type = b2_staticBody;
        landing_BodyDef.position.Set(landing_positionX/PTM_RATIO, landing_positionY/PTM_RATIO);
        landing_BodyDef.userData = self;;
        _landingBody = world->CreateBody(&landing_BodyDef);

        b2PolygonShape landing_Shape;
        int dimension = 4;
        b2Vec2 vertices[] = {
            b2Vec2(49.800003f / PTM_RATIO, -9.799999f / PTM_RATIO),
            b2Vec2(49.800003f / PTM_RATIO, 9.600000f / PTM_RATIO),
            b2Vec2(-49.599998f / PTM_RATIO, 9.800000f / PTM_RATIO),
            b2Vec2(-49.599998f / PTM_RATIO, -9.799999f / PTM_RATIO)
            };
            
        landing_Shape.Set(vertices, dimension);
        b2FixtureDef landing_ShapeDef;
        landing_ShapeDef.shape = &landing_Shape;
        landing_ShapeDef.density = 1.0f; //PUT YOUR OWN VALUE HERE 
        landing_ShapeDef.friction = 1.0f; //PUT YOUR OWN VALUE HERE 
        landing_ShapeDef.restitution = 0.0f; //PUT YOUR OWN VALUE HERE 
        _landingFixture = _landingBody->CreateFixture(&landing_ShapeDef);
                
        
    }
    
    return self;
}

- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

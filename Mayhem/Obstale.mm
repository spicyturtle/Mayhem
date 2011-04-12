//
//  Player.mm
//  Mayhem
//
//  Created by Roger Hansen on 4/10/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle

+(Obstacle *)obstacleInWorld:(b2World *)world
{
    return [[self alloc] initWithWorld:world];
}

- (id)initWithWorld:(b2World *) world {
    
    self = [super initWithFile:@"redobstacle.png" rect:CGRectMake(0, 0, 152, 152)];
    if (self) {
        
        int obstacle_positionX = 400; //PUT YOUR OWN VALUE HERE
        int obstacle_positionY = 400; //PUT YOUR OWN VALUE HERE
        
        self.position = ccp(obstacle_positionX, obstacle_positionY);
        b2BodyDef obstacle_BodyDef;
        obstacle_BodyDef.type = b2_staticBody;
        obstacle_BodyDef.position.Set(obstacle_positionX/PTM_RATIO, obstacle_positionY/PTM_RATIO);
        obstacle_BodyDef.userData = self;
        b2Body *obstacle_body = world->CreateBody(&obstacle_BodyDef);

        b2PolygonShape obstacle_Shape;
            
        obstacle_Shape.SetAsBox(self.contentSize.width/PTM_RATIO/2, self.contentSize.height/PTM_RATIO/2);
                                
                                
        b2FixtureDef obstacle_ShapeDef;
        obstacle_ShapeDef.shape = &obstacle_Shape;
        obstacle_ShapeDef.density = 1.0f; //PUT YOUR OWN VALUE HERE 
        obstacle_ShapeDef.friction = 0.2f; //PUT YOUR OWN VALUE HERE 
        obstacle_ShapeDef.restitution = 1.0f; //PUT YOUR OWN VALUE HERE 
        obstacle_body->CreateFixture(&obstacle_ShapeDef);
        
    }
    
    return self;
}

- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

//
//  Weapon.mm
//  Mayhem
//
//  Created by Kim Sørensen on 4/6/11.
//  Copyright 2011 SpicyTurtle. All rights reserved.
//

#import "Weapon.h"


@implementation Weapon

+(Weapon *)WeaponInWorld:(b2World *)world point:(b2Vec2)pos  
{   
    return [[self alloc] initWithWorld:world point:pos];
}

- (id)initWithWorld:(b2World *)world point:(b2Vec2)pos{
    
        
    self = [super initWithFile:@"greenLaserRay.png" rect:CGRectMake(pos.x, pos.y, 2, 15)];
    if (self) {
    
        // Create weapon body
        b2BodyDef weaponBodyDef;        
        weaponBodyDef.type = b2_dynamicBody;
        weaponBodyDef.position.Set(pos.x, pos.y);
        weaponBodyDef.userData = self;
        _weaponBody = world->CreateBody(&weaponBodyDef);
        
        // Create weapon shape
        b2PolygonShape weaponShape;
        weaponShape.SetAsBox(self.contentSize.width/(2*PTM_RATIO), self.contentSize.height/(2*PTM_RATIO));
        
        // Create shape definition and add to body
        b2FixtureDef weaponShapeDef;
        weaponShapeDef.shape = &weaponShape;
        _weaponFixture = _weaponBody->CreateFixture(&weaponShapeDef);
    }
    
    return self;
}


- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end

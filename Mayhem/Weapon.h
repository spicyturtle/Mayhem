//
//  Weapon.h
//  Mayhem
//
//  Created by Kim Sørensen on 4/6/11.
//  Copyright 2011 SpicyTurtle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import "Common.h"

@interface Weapon : CCSprite {
    b2Body *_weaponBody;
    b2Fixture *_weaponFixture;
}

+(Weapon *)WeaponInWorld:(b2World *)world point:(b2Vec2)pos angle:(float32)angle;

-(id)initWithWorld:(b2World *)world point:(b2Vec2)pos angle:(float32)angle;

@end

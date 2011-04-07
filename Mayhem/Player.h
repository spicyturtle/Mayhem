//
//  Player.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import "Common.h"
#import "Weapon.h"

@interface Player : CCSprite {
    b2Body *_playerBody;
    b2Fixture *_playerFixture;
}

+(Player *)playerInWorld:(b2World *)world;

-(id)initWithWorld:(b2World *)world;

// Control methods
-(void) turnLeft;
-(void) turnRight;
-(Weapon*) fire;
-(void) accelerate;

@end

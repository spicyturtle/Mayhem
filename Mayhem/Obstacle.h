//
//  Player.h
//  Mayhem
//
//  Created by Roger Hansen on 4/10/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import "Common.h"

@interface Obstacle : CCSprite {
    b2Body *_obstacleBody;
    b2Fixture *_obstacleFixture;
}

+(Obstacle *)obstacleInWorld:(b2World *)world;

-(id)initWithWorld:(b2World *)world;

@end

//
//  StaticEnemy.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/7/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import "Common.h"
#import "Weapon.h"

@interface StaticEnemy : CCSprite {
    b2Body *_body;
    b2Fixture *_fixture;
}

+(StaticEnemy *)enemyInWorld:(b2World *)world atX:(float)x andY:(float) y;

-(id)initWithWorld:(b2World *)world atPos:(CGPoint) pos;

@end

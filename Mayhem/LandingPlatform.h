//
//  LandingPlatform.h
//  Mayhem
//
//  Created by Roger Hansen on 4/10/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import "Common.h"

@interface LandingPlatform : CCSprite {
    b2Body *_landingBody;
    b2Fixture *_landingFixture;
}

+(LandingPlatform *)landingPlatformInWorld:(b2World *)world;

-(id)initWithWorld:(b2World *)world;

@end

//
//  World.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/5/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "cocos2d.h"

#import "Common.h"


// Macros for world constants
#define GRAVITY b2Vec2(0.0f, -0.5f)
#define DOSLEEP true


@interface World : NSObject {
    
}

+(b2World *)getWorld;

@end

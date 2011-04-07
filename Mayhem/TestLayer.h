//
//  TestLayer.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import "Common.h"
#import "Player.h"
#import "StaticEnemy.h"
#import "World.h"

@interface TestLayer : CCLayerColor {
    
    // Box2D world object
    b2World *_world;

}
@property (nonatomic, retain) Player *player;

+(TestLayer *)layerWithWorld:(b2World *)world andPlayer:(Player *)player;

-(id)initWithWorld: (b2World *)world andPlayer:(Player *)player;

@end

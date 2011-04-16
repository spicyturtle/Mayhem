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
#import "MyContactListener.h"

#import "Common.h"
#import "Player.h"
#import "StaticEnemy.h"
#import "World.h"
#import "LandingPlatform.h"
#import "GameOverScene.h"
#import "Obstacle.h"

@interface TestLayer : CCLayerColor {
    
    // Box2D world object
    b2World *_world;
        
    CCParticleFire *pe;
    
    // Contact Listener
    MyContactListener *_contactListener;
    
    // TileMap
    CCTMXLayer *_background;
}
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *background;

+(TestLayer *)layerWithWorld:(b2World *)world andPlayer:(Player *)player;

-(id)initWithWorld: (b2World *)world andPlayer:(Player *)player;
- (void) addRectAt:(CGPoint)p withSize:(CGPoint)size dynamic:(BOOL)d rotation:(long)r friction:(long)f density:(long)dens restitution:(long)rest boxId:(int)boxId;
- (void) drawBodyTiles;


@end

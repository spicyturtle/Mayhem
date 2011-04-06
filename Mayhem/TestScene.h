//
//  TestScene.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "TestLayer.h"
#import "GUILayer.h"
#import "Player.h"
#import "World.h"

@interface TestScene : CCScene 
{
    
    // Box2D world object
    b2World *_world;
    
    Player *_player;
}

@property (nonatomic, retain) Player *player;
@property (nonatomic) b2World *world;

+(TestScene *)scene;

@end

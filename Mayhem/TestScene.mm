//
//  TestScene.mm
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "TestScene.h"


@implementation TestScene

@synthesize player = _player;
@synthesize world = _world;

- (id)init {
    self = [super init];
    if (self) {
        
        // Create world
        self.world = [World getWorld];
        
        // Create player
        self.player = [Player playerInWorld:_world];
    }
    return self;
}

+(TestScene *)scene
{
    // Create a MainMenuScene
    TestScene *scene = [TestScene node];

    // Add a TestLayer to scene
    TestLayer *layer = [TestLayer layerWithWorld:scene->_world andPlayer:scene->_player];
    [scene  addChild:layer];
    
    // Add  GUILayer that reacts with the player.
    GUILayer *gui = [GUILayer GUIToPlayer:scene.player];
    [scene addChild:gui];
    
    // Return The scene
    return scene;
}

-(void)dealloc
{
    delete _world;
    
    // Uncertain on this one..
    [_player release];
    
    [super dealloc];
}

@end

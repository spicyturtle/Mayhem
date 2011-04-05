//
//  MainMenuScene.mm
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "MainMenuScene.h"


@implementation MainMenuScene

@synthesize layer = _layer;

- (id)init {
    self = [super init];
    if (self) {
        // Add layers here
        self.layer = [MainMenuLayer node];
        [self addChild:_layer];
    }
    return self;
}

+(MainMenuScene *)scene
{
    // Create a MainMenuScene
    MainMenuScene *scene = [MainMenuScene node];
    
    // Return The scene
    return scene;
}

@end

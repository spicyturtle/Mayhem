//
//  TestScene.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "TestScene.h"


@implementation TestScene


+(TestScene *)scene
{
    // Create a MainMenuScene
    TestScene *scene = [TestScene node];
    
    // Return The scene
    return scene;
}

@end

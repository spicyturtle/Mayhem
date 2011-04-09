//
//  GUILayer.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/5/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "GUILayer.h"


@implementation GUILayer

+(GUILayer *)GUIToPlayer:(Player *)player
{
    return [[self alloc] initWithPlayer:player];
}

- (id)initWithPlayer:(Player *)player {
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
    if (self) {
        // Get winSize
        CGSize winSize = GET_WINSIZE();
        
        // Create button sprites
        // Turn Left
        MenuButton *leftButton = [MenuButton buttonFromFile:@"ButtonLeft.png" Target:player selector:@selector(turnLeft)];
        leftButton.position = ccp(60.0, 60.0);
        [self addChild:leftButton];
        
        // Turn Right
        MenuButton *rightButton = [MenuButton buttonFromFile:@"ButtonRight.png" Target:player selector:@selector(turnRight)];
        rightButton.position = ccp(120.0, 60.0);
        [self addChild:rightButton];
        
        // Fire
        MenuButton *fireButton = [MenuButton buttonFromFile:@"ButtonFire.png" Target:player selector:@selector(fire)];
        fireButton.position = ccp(winSize.width - 60.0, 60.0);
        [self addChild:fireButton];
        
        // Accelerate
        MenuButton *accelerateButton = [MenuButton buttonFromFile:@"ButtonAccelerate.png" Target:player selector:@selector(accelerate)];
        accelerateButton.position = ccp(winSize.width - 120.0, 60.0);
        [self addChild:accelerateButton];
    }
    return self;
}

//-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    printf("Began\n");
//    
//    // Check to see if a button was pressed
//    
//}
//
//-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    printf("Ended\n");    
//}
//
//-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    printf("Canceled\n");
//}

@end

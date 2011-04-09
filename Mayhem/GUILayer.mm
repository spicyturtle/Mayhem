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
        
        // Set touch enabled
        self.isTouchEnabled = YES;
        
        // Create button sprites
        
        // Turn Left
        MenuButton *leftButton = [MenuButton buttonFromFile:@"ButtonLeft.png" Target:player selector:@selector(turnLeft)];
        leftButton.position = ccp(60.0, 60.0);
        [self addChild:leftButton];
        
        // Turn Right
        
        // Fire
        
        // Accelerate
        
        /*
        
        // Create the four controller buttons
        // Turn left
        CCMenuItem *turnLeftButton;
        turnLeftButton = [CCMenuItemImage itemFromNormalImage:@"ButtonLeft.png" selectedImage:@"ButtonLeftSel.png" target:player selector:@selector(turnLeft)];
        turnLeftButton.position = ccp(60,60);

        // Turn right
        CCMenuItem *turnRightButton;
        turnRightButton = [CCMenuItemImage itemFromNormalImage:@"ButtonRight.png" selectedImage:@"ButtonRightSel.png" target:player selector:@selector(turnRight)];
        turnRightButton.position = ccp(120,60);
        
        // Fire
        CCMenuItem *fireButton;
        fireButton = [CCMenuItemImage itemFromNormalImage:@"ButtonFire.png" selectedImage:@"ButtonFireSel.png" block: ^(id sender)
                      {
                          Weapon *bullet = [player fire];
                          
                          [player.parent addChild:bullet];
                    
                      }];
        fireButton.position = ccp(winSize.width - 60 ,60);  
        
        // Thrust
        CCMenuItem *accelerateButton;
        accelerateButton = [CCMenuItemImage itemFromNormalImage:@"ButtonAccelerate.png" selectedImage:@"ButtonAccelerateSel.png" target:player selector:@selector(accelerate)];
        accelerateButton.position = ccp(winSize.width - 120 ,60);
        
        // Create Menu with all items and add to layer
        CCMenu *gui;
        gui = [CCMenu menuWithItems:turnLeftButton, turnRightButton, accelerateButton, fireButton , nil];
        gui.position = CGPointZero;
        
        [self addChild:gui];
         
         */
    }
    return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    printf("Began\n");
    
    // Check to see if a button was pressed
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    printf("Ended\n");    
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    printf("Canceled\n");
}

@end

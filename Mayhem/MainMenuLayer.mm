//
//  MainMenuLayer.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "MainMenuLayer.h"


@implementation MainMenuLayer

@synthesize title = _title;

- (id)init {
    self = [super init];
    if (self) {
        // Init the main menu layer here...
        
        // get winSie from director
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Create a label for menu title
        self.title = [[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Arial" fontSize:40] retain];
        self.title.position = ccp(winSize.width/2, winSize.height - (self.title.contentSize.height/2));
        [self addChild:_title];
        
        // Create a startGameButton
        CCMenuItem *startGameButton = [CCMenuItemImage itemFromNormalImage:@"ButtonStartGame.png" selectedImage:@"ButtonStartGameSel.png" target:self selector:@selector(startGameButtonTapped)];
        startGameButton.position = ccp(winSize.width/2, winSize.height/2);
        
        // Create menu to hold buttons
        CCMenu *mainMenu = [CCMenu menuWithItems:startGameButton, nil];
        mainMenu.position = CGPointZero;
        [self addChild:mainMenu];
    }
    return self;
}

-(void)startGameButtonTapped
{
    // Change scene to first game scene, TestScene atm.
    [[CCDirector sharedDirector] replaceScene:[TestScene scene]];
}

@end

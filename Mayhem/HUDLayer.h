//
//  Player.h
//  Mayhem
//
//  Created by Kim Sørensen on 4/10/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "Common.h"

#import "Weapon.h"

@interface HUDLayer : CCLayerColor {    
    Player *_player;
    
    CCLabelAtlas *fuelgauge;
}

+(HUDLayer *)HUDToPlayer:(Player *)player;

-(id)initWithPlayer:(Player *)player;

-(void)updateHUD:(ccTime) dt;

@end
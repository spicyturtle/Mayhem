//
//  GUILayer.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/5/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Player.h"
#import "Common.h"

@interface GUILayer : CCLayerColor {
    
}

+(GUILayer *)GUIToPlayer:(Player *)player;

-(id)initWithPlayer:(Player *)player;

@end

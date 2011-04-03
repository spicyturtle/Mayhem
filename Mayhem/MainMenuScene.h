//
//  MainMenuScene.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "MainMenuLayer.h"

@interface MainMenuScene : CCScene {
    MainMenuLayer *_layer;
}

@property (nonatomic, retain) MainMenuLayer *layer;

+(MainMenuScene *)scene;

@end
